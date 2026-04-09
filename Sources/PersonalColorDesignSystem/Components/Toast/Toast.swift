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
        .padding(.bottom, 32)
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
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                            withAnimation(.easeOut(duration: 0.3)) {
                                isPresented = false
                            }
                        }
                    }
                    .onTapGesture {
                        withAnimation(.easeOut(duration: 0.2)) {
                            isPresented = false
                        }
                    }
            }
        }
        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: isPresented)
    }
}

// MARK: - View Extension

public extension View {

    /// Show a toast message at the bottom of the screen.
    ///
    /// ```swift
    /// .toast(isPresented: $showToast, message: "저장됐습니다", type: .success)
    /// ```
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

    /// Show a toast with a custom SF Symbol icon.
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
