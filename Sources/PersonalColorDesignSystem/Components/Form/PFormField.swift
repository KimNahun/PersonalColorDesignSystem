import SwiftUI

// MARK: - PFormFieldState

public enum PFormFieldState {
    case normal, error, success
}

// MARK: - PFormField

/// label + 입력 컴포넌트 슬롯 + 상태 메시지 래퍼.
/// 모든 폼 입력 요소를 일관된 레이아웃으로 감싼다.
///
/// ```swift
/// PFormField(label: "이메일", state: .error, message: "올바른 이메일 형식이 아닙니다") {
///     PTextField(placeholder: "name@example.com", text: $email)
/// }
///
/// PFormField(label: "비밀번호", state: .normal) {
///     PSecureField(placeholder: "8자 이상 입력", text: $password)
/// }
/// ```
public struct PFormField<Content: View>: View {
    @Environment(\.pThemeColors) private var theme
    let label: String
    let state: PFormFieldState
    let message: String?
    let content: Content

    public init(
        label: String,
        state: PFormFieldState = .normal,
        message: String? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.label = label
        self.state = state
        self.message = message
        self.content = content()
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: PSpacing.xs) {
            Text(label)
                .font(.pCaption(13))
                .foregroundStyle(labelColor)

            content
                .overlay(
                    RoundedRectangle(cornerRadius: PRadius.md)
                        .strokeBorder(borderColor, lineWidth: state == .normal ? 0 : PBorder.thin)
                )

            if let message, state != .normal {
                HStack(spacing: PSpacing.xs) {
                    Image(systemName: state == .error ? "exclamationmark.circle" : "checkmark.circle")
                        .font(.system(size: 12))
                    Text(message)
                        .font(.pCaption(12))
                }
                .foregroundStyle(messageColor)
                .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
        .animation(PAnimation.springFast, value: state == .error)
    }

    private var labelColor: Color {
        switch state {
        case .normal: return Color.pTextSecondary
        case .error: return theme.destructive
        case .success: return theme.success
        }
    }

    private var borderColor: Color {
        switch state {
        case .normal: return .clear
        case .error: return theme.destructive.opacity(0.7)
        case .success: return theme.success.opacity(0.7)
        }
    }

    private var messageColor: Color {
        switch state {
        case .normal: return Color.pTextTertiary
        case .error: return theme.destructive
        case .success: return theme.success
        }
    }
}

// MARK: - Preview

#Preview("PFormField") {
    PFormFieldPreviewWrapper()
}

private struct PFormFieldPreviewWrapper: View {
    @State private var email = "invalid-email"
    @State private var password = ""
    @State private var name = "김나훈"

    var body: some View {
        ZStack {
            PGradientBackground()
            ScrollView {
                VStack(spacing: PSpacing.xl) {
                    PFormField(label: "이메일", state: .error, message: "올바른 이메일 형식이 아닙니다") {
                        PTextField(placeholder: "name@example.com", text: $email)
                    }

                    PFormField(label: "비밀번호", state: .normal, message: nil) {
                        PSecureField(placeholder: "8자 이상 입력하세요", text: $password)
                    }

                    PFormField(label: "이름", state: .success, message: "사용 가능한 이름입니다") {
                        PTextField(placeholder: "이름 입력", text: $name)
                    }
                }
                .padding(PSpacing.xl)
            }
        }
    }
}
