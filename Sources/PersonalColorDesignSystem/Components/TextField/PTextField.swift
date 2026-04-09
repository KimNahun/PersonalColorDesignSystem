import SwiftUI

// MARK: - PTextField

/// 글래스 스타일 텍스트 필드. 검색/입력 용도.
///
/// ```swift
/// PTextField(placeholder: "검색", text: $query, leadingIcon: "magnifyingglass", trailingIcon: "xmark.circle.fill")
/// ```
public struct PTextField: View {
    @Environment(\.pThemeColors) private var theme
    let placeholder: String
    @Binding var text: String
    let leadingIcon: String?
    let trailingIcon: String?

    public init(
        placeholder: String,
        text: Binding<String>,
        leadingIcon: String? = nil,
        trailingIcon: String? = nil
    ) {
        self.placeholder = placeholder
        self._text = text
        self.leadingIcon = leadingIcon
        self.trailingIcon = trailingIcon
    }

    public var body: some View {
        HStack(spacing: 8) {
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
                TextField("", text: $text)
                    .foregroundStyle(Color.pTextPrimary)
                    .font(.pBody(15))
                    .tint(theme.accentPrimary)
            }

            if let trailingIcon, !text.isEmpty {
                Button {
                    text = ""
                } label: {
                    Image(systemName: trailingIcon)
                        .foregroundStyle(Color.pTextTertiary)
                        .font(.system(size: 15))
                }
            }
        }
        .padding(.horizontal, 12)
        .frame(height: 44)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.pGlassFill)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .strokeBorder(Color.pGlassBorder, lineWidth: 0.5)
                )
        )
    }
}

// MARK: - Preview

#Preview("PTextField") {
    PTextFieldPreviewWrapper()
}

private struct PTextFieldPreviewWrapper: View {
    @State private var search = ""
    @State private var plain = ""
    @State private var filled = "입력된 텍스트"

    var body: some View {
        ZStack {
            PGradientBackground()

            VStack(alignment: .leading, spacing: 20) {
                Text("검색 필드")
                    .font(.pCaption(12)).foregroundStyle(Color.pTextTertiary).textCase(.uppercase)
                PTextField(placeholder: "검색어를 입력하세요", text: $search,
                           leadingIcon: "magnifyingglass", trailingIcon: "xmark.circle.fill")

                Text("아이콘 없음")
                    .font(.pCaption(12)).foregroundStyle(Color.pTextTertiary).textCase(.uppercase)
                PTextField(placeholder: "이름 입력", text: $plain)

                Text("텍스트 있는 상태")
                    .font(.pCaption(12)).foregroundStyle(Color.pTextTertiary).textCase(.uppercase)
                PTextField(placeholder: "입력", text: $filled,
                           leadingIcon: "person", trailingIcon: "xmark.circle.fill")
            }
            .padding()
        }
    }
}
