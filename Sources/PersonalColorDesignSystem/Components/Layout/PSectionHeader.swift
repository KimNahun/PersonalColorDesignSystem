import SwiftUI

// MARK: - PSectionHeader

/// 섹션 제목 + 선택적 trailing 액션 버튼.
///
/// ```swift
/// PSectionHeader("최근 항목")
/// PSectionHeader("추천", actionTitle: "전체 보기") { navigateToAll() }
/// ```
public struct PSectionHeader: View {
    let title: String
    let actionTitle: String?
    let action: (() -> Void)?

    public init(
        _ title: String,
        actionTitle: String? = nil,
        action: (() -> Void)? = nil
    ) {
        self.title = title
        self.actionTitle = actionTitle
        self.action = action
    }

    public var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(title)
                .font(.pTitle(17))
                .foregroundStyle(Color.pTextPrimary)

            Spacer()

            if let actionTitle, let action {
                Button(action: action) {
                    Text(actionTitle)
                        .font(.pCaption(13))
                        .foregroundStyle(Color.pTextTertiary)
                }
            }
        }
    }
}

// MARK: - Preview

#Preview("PSectionHeader") {
    ZStack {
        PGradientBackground()
        VStack(spacing: PSpacing.xxl) {
            PSectionHeader("최근 항목")
            PDivider()
            PSectionHeader("추천 콘텐츠", actionTitle: "전체 보기") { }
            PDivider()
            PSectionHeader("설정")
        }
        .padding(PSpacing.xl)
    }
}
