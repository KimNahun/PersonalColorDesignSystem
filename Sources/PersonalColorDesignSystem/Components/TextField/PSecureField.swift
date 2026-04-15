import SwiftUI

// MARK: - PSecureField

/// 비밀번호 입력 전용 글래스 필드. eye 아이콘으로 표시/숨김 토글.
///
/// ```swift
/// PSecureField(placeholder: "비밀번호", text: $password)
/// PSecureField(placeholder: "비밀번호 확인", text: $confirm, leadingIcon: "lock")
/// ```
public struct PSecureField: View {
    @Environment(\.pThemeColors) private var theme
    let placeholder: String
    @Binding var text: String
    let leadingIcon: String?
    @State private var isRevealed = false

    public init(
        placeholder: String,
        text: Binding<String>,
        leadingIcon: String? = nil
    ) {
        self.placeholder = placeholder
        self._text = text
        self.leadingIcon = leadingIcon
    }

    public var body: some View {
        HStack(spacing: PSpacing.sm) {
            if let leadingIcon {
                Image(systemName: leadingIcon)
                    .foregroundStyle(Color.pTextTertiary)
                    .font(.system(size: 15, weight: .regular))
                    .frame(width: 20)
            }

            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundStyle(Color.pTextTertiary)
                        .font(.pBody(15))
                }
                Group {
                    if isRevealed {
                        TextField("", text: $text)
                    } else {
                        SecureField("", text: $text)
                    }
                }
                .foregroundStyle(Color.pTextPrimary)
                .font(.pBody(15))
                .tint(theme.accentPrimary)
            }

            Button {
                isRevealed.toggle()
            } label: {
                Image(systemName: isRevealed ? "eye.slash" : "eye")
                    .foregroundStyle(isRevealed ? theme.accentPrimary : Color.pTextTertiary)
                    .font(.system(size: 15))
                    .animation(PAnimation.springFast, value: isRevealed)
            }
        }
        .padding(.horizontal, PSpacing.md)
        .frame(height: 44)
        .background(
            RoundedRectangle(cornerRadius: PRadius.md)
                .fill(Color.pGlassFill)
                .overlay(
                    RoundedRectangle(cornerRadius: PRadius.md)
                        .strokeBorder(Color.pGlassBorder, lineWidth: PBorder.hairline)
                )
        )
    }
}

// MARK: - Preview

#Preview("PSecureField") {
    PSecureFieldPreviewWrapper()
}

private struct PSecureFieldPreviewWrapper: View {
    @State private var password = ""
    @State private var confirm = "mypassword123"

    var body: some View {
        ZStack {
            PGradientBackground()
            VStack(alignment: .leading, spacing: PSpacing.xl) {
                Text("기본")
                    .font(.pCaption(12)).foregroundStyle(Color.pTextTertiary).textCase(.uppercase)
                PSecureField(placeholder: "비밀번호를 입력하세요", text: $password)

                Text("아이콘 + 입력된 상태")
                    .font(.pCaption(12)).foregroundStyle(Color.pTextTertiary).textCase(.uppercase)
                PSecureField(placeholder: "비밀번호 확인", text: $confirm, leadingIcon: "lock")
            }
            .padding(PSpacing.xl)
        }
    }
}
