import SwiftUI

// MARK: - PPageIndicator

/// 온보딩·캐러셀용 페이지 닷 인디케이터.
///
/// ```swift
/// PPageIndicator(total: 4, current: $currentPage)
/// PPageIndicator(total: 3, current: $page, dotSize: 8, spacing: 10)
/// ```
public struct PPageIndicator: View {
    @Environment(\.pThemeColors) private var theme
    let total: Int
    @Binding var current: Int
    let dotSize: CGFloat
    let spacing: CGFloat
    let isInteractive: Bool

    public init(
        total: Int,
        current: Binding<Int>,
        dotSize: CGFloat = 6,
        spacing: CGFloat = PSpacing.sm,
        isInteractive: Bool = false
    ) {
        self.total = total
        self._current = current
        self.dotSize = dotSize
        self.spacing = spacing
        self.isInteractive = isInteractive
    }

    public var body: some View {
        HStack(spacing: spacing) {
            ForEach(0..<total, id: \.self) { index in
                Capsule()
                    .fill(index == current ? theme.accentPrimary : Color.pGlassBorder)
                    .frame(
                        width: index == current ? dotSize * 2.5 : dotSize,
                        height: dotSize
                    )
                    .animation(PAnimation.spring, value: current)
                    .onTapGesture {
                        guard isInteractive else { return }
                        HapticManager.selection()
                        withAnimation(PAnimation.spring) { current = index }
                    }
            }
        }
    }
}

// MARK: - Preview

#Preview("PPageIndicator") {
    PPageIndicatorPreviewWrapper()
}

private struct PPageIndicatorPreviewWrapper: View {
    @State private var page = 1

    var body: some View {
        ZStack {
            PGradientBackground()
            VStack(spacing: PSpacing.xxl) {
                PPageIndicator(total: 4, current: $page, isInteractive: true)

                HStack(spacing: PSpacing.md) {
                    CommonButton(title: "이전", style: .outlined, size: .small) {
                        withAnimation(PAnimation.spring) { page = max(0, page - 1) }
                    }
                    CommonButton(title: "다음", size: .small) {
                        withAnimation(PAnimation.spring) { page = min(3, page + 1) }
                    }
                }

                Text("인터랙티브 (탭 가능)")
                    .font(.pCaption(12)).foregroundStyle(Color.pTextTertiary)
                PPageIndicator(total: 5, current: $page, dotSize: 8, spacing: 10, isInteractive: true)
            }
        }
    }
}
