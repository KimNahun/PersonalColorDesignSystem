import SwiftUI

// MARK: - PTabItem

public struct PTabItem {
    public let icon: String
    public let selectedIcon: String
    public let title: String

    public init(icon: String, selectedIcon: String? = nil, title: String) {
        self.icon = icon
        self.selectedIcon = selectedIcon ?? icon + ".fill"
        self.title = title
    }
}

// MARK: - PTabBar

/// 커스텀 탭바. selectedColor = accentPrimary, 글래스 배경.
///
/// ```swift
/// PTabBar(
///     items: [
///         PTabItem(icon: "house", title: "홈"),
///         PTabItem(icon: "magnifyingglass", title: "탐색"),
///         PTabItem(icon: "person", title: "프로필"),
///     ],
///     selected: $currentTab
/// )
/// ```
public struct PTabBar: View {
    @Environment(\.pThemeColors) private var theme
    let items: [PTabItem]
    @Binding var selected: Int

    public init(items: [PTabItem], selected: Binding<Int>) {
        self.items = items
        self._selected = selected
    }

    public var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                Button {
                    HapticManager.selection()
                    withAnimation(PAnimation.springFast) {
                        selected = index
                    }
                } label: {
                    VStack(spacing: PSpacing.xxs + 1) {
                        Image(systemName: selected == index ? item.selectedIcon : item.icon)
                            .font(.system(size: 22, weight: selected == index ? .semibold : .regular))
                            .foregroundStyle(selected == index ? theme.accentPrimary : Color.pTextTertiary)
                            .scaleEffect(selected == index ? 1.05 : 1.0)
                            .animation(PAnimation.springFast, value: selected)

                        Text(item.title)
                            .font(.system(size: 10, weight: selected == index ? .semibold : .regular))
                            .foregroundStyle(selected == index ? theme.accentPrimary : Color.pTextTertiary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, PSpacing.sm)
                }
            }
        }
        .padding(.horizontal, PSpacing.xs)
        .background(
            Color.pTabBarBackground
                .overlay(alignment: .top) {
                    PDivider()
                }
        )
    }
}

// MARK: - Preview

#Preview("PTabBar") {
    PTabBarPreviewWrapper()
}

private struct PTabBarPreviewWrapper: View {
    @State private var selected = 0
    let items: [PTabItem] = [
        PTabItem(icon: "house", title: "홈"),
        PTabItem(icon: "magnifyingglass", title: "탐색"),
        PTabItem(icon: "bell", title: "알림"),
        PTabItem(icon: "person", title: "프로필"),
    ]

    var body: some View {
        ZStack {
            PGradientBackground()
            VStack {
                Spacer()
                Text("탭 \(selected + 1) 선택됨")
                    .foregroundStyle(Color.pTextSecondary)
                Spacer()
                PTabBar(items: items, selected: $selected)
            }
        }
        .ignoresSafeArea(edges: .bottom)
    }
}
