import SwiftUI

// MARK: - ActionCheckModal

/// 확인/취소 액션 모달.
///
/// ```swift
/// .actionCheckModal(
///     isPresented: $showModal,
///     title: "정말 삭제하시겠습니까?",
///     onConfirm: { delete() }
/// )
/// ```
public struct ActionCheckModal: View {
    let title: String
    let confirmLabel: String
    let cancelLabel: String
    let onConfirm: () -> Void
    let onCancel: () -> Void

    @Environment(\.pThemeColors) var theme

    public init(
        title: String,
        confirmLabel: String = "예",
        cancelLabel: String = "아니오",
        onConfirm: @escaping () -> Void,
        onCancel: @escaping () -> Void = {}
    ) {
        self.title = title
        self.confirmLabel = confirmLabel
        self.cancelLabel = cancelLabel
        self.onConfirm = onConfirm
        self.onCancel = onCancel
    }

    public var body: some View {
        VStack(spacing: 24) {
            Text(title)
                .font(.pTitle(17))
                .foregroundStyle(Color.pTextPrimary)
                .multilineTextAlignment(.center)

            HStack(spacing: 10) {
                Button(cancelLabel) { onCancel() }
                    .buttonStyle(ModalActionButtonStyle(isPrimary: false, accentColor: theme.accentPrimary))

                Button(confirmLabel) { onConfirm() }
                    .buttonStyle(ModalActionButtonStyle(isPrimary: true, accentColor: theme.accentPrimary))
            }
        }
        .padding(24)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(red: 0.15, green: 0.13, blue: 0.22).opacity(0.97))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(Color.pGlassBorder, lineWidth: 0.5)
                )
                .shadow(color: Color.pShadow, radius: 24, x: 0, y: 8)
        )
        .padding(.horizontal, 40)
    }
}

// MARK: - Internal Button Style

private struct ModalActionButtonStyle: ButtonStyle {
    let isPrimary: Bool
    let accentColor: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.pBodyMedium(15))
            .foregroundStyle(isPrimary ? Color.white : Color.pTextSecondary)
            .frame(maxWidth: .infinity)
            .frame(height: 46)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(isPrimary ? accentColor : Color.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(Color.pGlassBorder, lineWidth: isPrimary ? 0 : 0.5)
                    )
            )
            .opacity(configuration.isPressed ? 0.7 : 1.0)
    }
}

// MARK: - View Modifier

private struct ActionCheckModalModifier: ViewModifier {
    @Binding var isPresented: Bool
    let title: String
    let confirmLabel: String
    let cancelLabel: String
    let onConfirm: () -> Void
    let onCancel: () -> Void

    func body(content: Content) -> some View {
        ZStack {
            content

            if isPresented {
                Color.black.opacity(0.55)
                    .ignoresSafeArea()
                    .transition(.opacity)

                ActionCheckModal(
                    title: title,
                    confirmLabel: confirmLabel,
                    cancelLabel: cancelLabel,
                    onConfirm: {
                        onConfirm()
                        isPresented = false
                    },
                    onCancel: {
                        onCancel()
                        isPresented = false
                    }
                )
                .transition(.scale(scale: 0.9).combined(with: .opacity))
            }
        }
        .animation(.spring(response: 0.3, dampingFraction: 0.8), value: isPresented)
    }
}

public extension View {
    func actionCheckModal(
        isPresented: Binding<Bool>,
        title: String,
        confirmLabel: String = "예",
        cancelLabel: String = "아니오",
        onConfirm: @escaping () -> Void,
        onCancel: @escaping () -> Void = {}
    ) -> some View {
        modifier(ActionCheckModalModifier(
            isPresented: isPresented,
            title: title,
            confirmLabel: confirmLabel,
            cancelLabel: cancelLabel,
            onConfirm: onConfirm,
            onCancel: onCancel
        ))
    }
}

// MARK: - Preview

#Preview("ActionCheckModal") {
    ActionCheckModalPreviewWrapper()
}

private struct ActionCheckModalPreviewWrapper: View {
    @State private var showDefault = false
    @State private var showCustom = false

    var body: some View {
        ZStack {
            PGradientBackground()

            VStack(spacing: 16) {
                Button("기본 모달 보기") { showDefault = true }
                    .font(.pBodyMedium(15))
                    .foregroundStyle(Color.pTextPrimary)
                    .padding(.horizontal, 20).frame(height: 44)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.pGlassFill))

                Button("커스텀 라벨 모달") { showCustom = true }
                    .font(.pBodyMedium(15))
                    .foregroundStyle(Color.pTextPrimary)
                    .padding(.horizontal, 20).frame(height: 44)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.pGlassFill))
            }
        }
        .actionCheckModal(isPresented: $showDefault, title: "정말 삭제하시겠습니까?", onConfirm: {})
        .actionCheckModal(isPresented: $showCustom, title: "회원 탈퇴 시\n모든 데이터가 삭제됩니다.", confirmLabel: "탈퇴하기", cancelLabel: "취소", onConfirm: {})
    }
}
