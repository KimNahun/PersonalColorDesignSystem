import SwiftUI

// MARK: - EmptyStateView

/// 데이터가 없을 때 표시하는 뷰.
///
/// ```swift
/// EmptyStateView()
///
/// EmptyStateView(
///     icon: "bookmark.slash",
///     title: "저장된 항목이 없습니다",
///     description: "관심 있는 콘텐츠를 저장해 보세요.",
///     actionTitle: "둘러보기",
///     action: { }
/// )
/// ```
public struct EmptyStateView: View {
    let icon: String
    let title: String
    let description: String?
    let actionTitle: String?
    let action: (() -> Void)?

    public init(
        icon: String = "tray",
        title: String = "정보가 없습니다",
        description: String? = nil,
        actionTitle: String? = nil,
        action: (() -> Void)? = nil
    ) {
        self.icon = icon
        self.title = title
        self.description = description
        self.actionTitle = actionTitle
        self.action = action
    }

    public var body: some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 56, weight: .light))
                .foregroundStyle(Color.pTextTertiary)

            Text(title)
                .font(.pTitle(17))
                .foregroundStyle(Color.pTextSecondary)
                .multilineTextAlignment(.center)

            if let description {
                Text(description)
                    .font(.pBody(14))
                    .foregroundStyle(Color.pTextTertiary)
                    .multilineTextAlignment(.center)
            }

            if let actionTitle, let action {
                CommonButton(title: actionTitle, style: .outlined, action: action)
                    .padding(.top, 4)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(24)
    }
}

// MARK: - Preview

#Preview("EmptyStateView") {
    ZStack {
        PGradientBackground()

        ScrollView {
            VStack(spacing: 40) {
                VStack(alignment: .leading) {
                    Text("기본")
                        .font(.pCaption(12)).foregroundStyle(Color.pTextTertiary).textCase(.uppercase)
                        .padding(.horizontal, 24)
                    EmptyStateView()
                }

                VStack(alignment: .leading) {
                    Text("설명 포함")
                        .font(.pCaption(12)).foregroundStyle(Color.pTextTertiary).textCase(.uppercase)
                        .padding(.horizontal, 24)
                    EmptyStateView(
                        icon: "bookmark.slash",
                        title: "저장된 항목이 없습니다",
                        description: "관심 있는 콘텐츠를\n저장해 보세요."
                    )
                }

                VStack(alignment: .leading) {
                    Text("액션 버튼 포함")
                        .font(.pCaption(12)).foregroundStyle(Color.pTextTertiary).textCase(.uppercase)
                        .padding(.horizontal, 24)
                    EmptyStateView(
                        icon: "magnifyingglass",
                        title: "검색 결과가 없습니다",
                        description: "다른 검색어로 시도해 보세요.",
                        actionTitle: "다시 검색",
                        action: {}
                    )
                }
            }
            .padding(.vertical)
        }
    }
}
