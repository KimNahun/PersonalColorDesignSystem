import SwiftUI

// MARK: - Toast Type

public enum ToastType {
    case success, warning, error, info

    var icon: String {
        switch self {
        case .success: return "checkmark.circle.fill"
        case .warning: return "exclamationmark.triangle.fill"
        case .error:   return "xmark.circle.fill"
        case .info:    return "info.circle.fill"
        }
    }

    var color: Color {
        switch self {
        case .success: return .pSuccess
        case .warning: return .pWarning
        case .error:   return .pDestructive
        case .info:    return .pAccentPrimary
        }
    }
}

// MARK: - Toast Data

public struct ToastData: Equatable {
    public let message: String
    public let type: ToastType
    public let customIcon: String?

    public init(message: String, type: ToastType = .info, customIcon: String? = nil) {
        self.message = message
        self.type = type
        self.customIcon = customIcon
    }

    public static func == (lhs: ToastData, rhs: ToastData) -> Bool {
        lhs.message == rhs.message && lhs.customIcon == rhs.customIcon
    }

    var iconName: String { customIcon ?? type.icon }
    var iconColor: Color { type.color }
}

// MARK: - Toast View

struct ToastView: View {
    @Environment(\.pThemeColors) private var theme
    let toast: ToastData

    private var iconColor: Color {
        switch toast.type {
        case .success: return .pSuccess
        case .warning: return .pWarning
        case .error:   return .pDestructive
        case .info:    return theme.accentPrimary
        }
    }

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: toast.iconName)
                .foregroundStyle(iconColor)
                .font(.system(size: 16, weight: .semibold))

            Text(toast.message)
                .foregroundStyle(Color.pTextPrimary)
                .font(.pBody(14))
                .lineLimit(2)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(
            Capsule()
                .fill(Color.pToastBackground)
                .overlay(
                    Capsule()
                        .strokeBorder(Color.pGlassBorder, lineWidth: 0.5)
                )
                .shadow(color: Color.pShadow, radius: 16, x: 0, y: 4)
        )
        .padding(.horizontal, 24)
    }
}

// MARK: - Toast Modifier

struct ToastModifier: ViewModifier {
    @Binding var isPresented: Bool
    let toast: ToastData
    let duration: TimeInterval

    func body(content: Content) -> some View {
        ZStack(alignment: .bottom) {
            content

            if isPresented {
                ToastView(toast: toast)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .onTapGesture {
                        withAnimation(.easeOut(duration: 0.2)) {
                            isPresented = false
                        }
                    }
            }
        }
        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: isPresented)
        // toast 메시지가 바뀔 때마다 이전 Task를 취소하고 새 dismiss Task 시작.
        // DispatchQueue.asyncAfter와 달리 stale closure 문제가 없다.
        .task(id: toast) {
            guard isPresented else { return }
            do {
                try await Task.sleep(nanoseconds: UInt64(duration * 1_000_000_000))
                withAnimation(.easeOut(duration: 0.3)) {
                    isPresented = false
                }
            } catch {
                // Task cancelled (새 toast 또는 수동 dismiss) → 아무것도 하지 않음
            }
        }
    }
}

// MARK: - Global Toast Manager

/// 앱 전역 토스트 관리자. 루트 뷰에 주입 후 어느 화면에서든 호출 가능.
///
/// ```swift
/// // 루트 뷰 (SampleAppView 등)
/// @State private var toastManager = PToastManager()
/// var body: some View {
///     ContentView()
///         .environment(toastManager)
///         .pGlobalToast(toastManager)
/// }
///
/// // 하위 뷰 어디서든
/// @Environment(PToastManager.self) var toastManager
/// toastManager.show("저장됐습니다", type: .success)
/// ```
@MainActor
@Observable
public final class PToastManager {
    public var toast: ToastData? = nil
    public var isPresented: Bool = false
    private var dismissTask: Task<Void, Never>? = nil

    public init() {}

    public func show(_ message: String, type: ToastType = .info, duration: TimeInterval = 2.5) {
        present(ToastData(message: message, type: type), duration: duration)
    }

    public func show(_ message: String, icon: String, type: ToastType = .info, duration: TimeInterval = 2.5) {
        present(ToastData(message: message, type: type, customIcon: icon), duration: duration)
    }

    public func dismiss() {
        dismissTask?.cancel()
        withAnimation(.easeOut(duration: 0.2)) { isPresented = false }
    }

    private func present(_ data: ToastData, duration: TimeInterval) {
        dismissTask?.cancel()
        toast = data
        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) { isPresented = true }
        dismissTask = Task {
            try? await Task.sleep(for: .seconds(duration))
            guard !Task.isCancelled else { return }
            withAnimation(.easeOut(duration: 0.3)) { isPresented = false }
        }
    }
}

// MARK: - Global Toast Modifier

private struct GlobalToastModifier: ViewModifier {
    let manager: PToastManager

    func body(content: Content) -> some View {
        content
            .overlay(alignment: .bottom) {
                if manager.isPresented, let toast = manager.toast {
                    ToastView(toast: toast)
                        .onTapGesture { manager.dismiss() }
                        .padding(.bottom, 32)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: manager.isPresented)
                }
            }
    }
}

// MARK: - View Extension

public extension View {

    /// 앱 루트에 1번만 적용. TabView/NavigationStack 화면 전환 시에도 토스트가 유지됨.
    ///
    /// ```swift
    /// SampleAppView()
    ///     .environment(toastManager)
    ///     .pGlobalToast(toastManager)
    /// ```
    func pGlobalToast(_ manager: PToastManager) -> some View {
        modifier(GlobalToastModifier(manager: manager))
    }

    /// 단일 화면 전용 토스트 (화면 전환 시 사라짐).
    func toast(
        isPresented: Binding<Bool>,
        message: String,
        type: ToastType = .info,
        duration: TimeInterval = 2.5
    ) -> some View {
        modifier(ToastModifier(
            isPresented: isPresented,
            toast: ToastData(message: message, type: type),
            duration: duration
        ))
    }

    /// 단일 화면 전용 토스트 — 커스텀 SF Symbol 아이콘.
    func toast(
        isPresented: Binding<Bool>,
        message: String,
        icon: String,
        type: ToastType = .info,
        duration: TimeInterval = 2.5
    ) -> some View {
        modifier(ToastModifier(
            isPresented: isPresented,
            toast: ToastData(message: message, type: type, customIcon: icon),
            duration: duration
        ))
    }
}
