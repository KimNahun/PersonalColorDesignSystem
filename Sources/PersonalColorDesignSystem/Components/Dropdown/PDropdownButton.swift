import SwiftUI

// MARK: - PDropdownButton

/// 버튼 탭 시 옵션 목록이 펼쳐지는 선택 컴포넌트.
///
/// ```swift
/// PDropdownButton(
///     placeholder: "카테고리 선택",
///     options: ["전체", "음악", "스포츠"],
///     selectedOption: $selected
/// )
/// ```
public struct PDropdownButton: View {
    let placeholder: String
    let options: [String]
    @Binding var selectedOption: String?
    @State private var isExpanded = false
    @Environment(\.pThemeColors) var theme

    public init(
        placeholder: String,
        options: [String],
        selectedOption: Binding<String?>
    ) {
        self.placeholder = placeholder
        self.options = options
        self._selectedOption = selectedOption
    }

    public var body: some View {
        triggerButton
            .overlay(alignment: .top) {
                if isExpanded {
                    dropdownList
                        .padding(.top, 48) // 버튼 높이(44) + 간격(4)
                        .transition(.opacity.combined(with: .move(edge: .top)))
                }
            }
            .zIndex(isExpanded ? 999 : 0)
            .animation(.spring(response: 0.3, dampingFraction: 0.8), value: isExpanded)
    }

    // MARK: Trigger Button

    private var triggerButton: some View {
        Button {
            isExpanded.toggle()
        } label: {
            HStack {
                Text(selectedOption ?? placeholder)
                    .font(.pBody(15))
                    .foregroundStyle(selectedOption != nil ? Color.pTextPrimary : Color.pTextTertiary)
                Spacer()
                Image(systemName: "chevron.down")
                    .foregroundStyle(Color.pTextTertiary)
                    .font(.system(size: 12, weight: .medium))
                    .rotationEffect(.degrees(isExpanded ? 180 : 0))
                    .animation(.spring(response: 0.3, dampingFraction: 0.8), value: isExpanded)
            }
            .padding(.horizontal, 14)
            .frame(height: 44)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.pGlassFill)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .strokeBorder(
                                isExpanded ? theme.accentPrimary.opacity(0.6) : Color.pGlassBorder,
                                lineWidth: 0.5
                            )
                    )
            )
        }
    }

    // MARK: Dropdown List

    private var dropdownList: some View {
        VStack(spacing: 0) {
            ForEach(Array(options.enumerated()), id: \.offset) { index, option in
                Button {
                    withAnimation(.spring(response: 0.25, dampingFraction: 0.8)) {
                        selectedOption = option
                        isExpanded = false
                    }
                } label: {
                    HStack {
                        Text(option)
                            .font(.pBody(15))
                            .foregroundStyle(
                                selectedOption == option ? theme.accentPrimary : Color.pTextPrimary
                            )
                        Spacer()
                        if selectedOption == option {
                            Image(systemName: "checkmark")
                                .foregroundStyle(theme.accentPrimary)
                                .font(.system(size: 12, weight: .semibold))
                        }
                    }
                    .padding(.horizontal, 14)
                    .frame(height: 44)
                }

                if index < options.count - 1 {
                    Color.pGlassBorder
                        .frame(height: 0.5)
                        .padding(.horizontal, 14)
                }
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.pToastBackground)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .strokeBorder(Color.pGlassBorder, lineWidth: 0.5)
                )
        )
    }
}

// MARK: - Preview

#Preview("PDropdownButton") {
    PDropdownPreviewWrapper()
}

private struct PDropdownPreviewWrapper: View {
    @State private var selected1: String? = nil
    @State private var selected2: String? = "스포츠"

    var body: some View {
        ZStack {
            PGradientBackground()

            VStack(spacing: 24) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("미선택 상태")
                        .font(.pCaption(12)).foregroundStyle(Color.pTextTertiary).textCase(.uppercase)
                    PDropdownButton(
                        placeholder: "카테고리를 선택하세요",
                        options: ["전체", "음악", "스포츠", "기술", "라이프스타일"],
                        selectedOption: $selected1
                    )
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("선택된 상태")
                        .font(.pCaption(12)).foregroundStyle(Color.pTextTertiary).textCase(.uppercase)
                    PDropdownButton(
                        placeholder: "카테고리",
                        options: ["전체", "음악", "스포츠"],
                        selectedOption: $selected2
                    )
                }
            }
            .padding()
        }
    }
}
