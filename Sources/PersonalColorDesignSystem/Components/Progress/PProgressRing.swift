import SwiftUI

// MARK: - PProgressRing

/// 원형 진행률 컴포넌트. 카운트다운·업로드 진행 표현.
///
/// ```swift
/// PProgressRing(progress: 0.75)
/// PProgressRing(progress: $uploadProgress, size: 80, lineWidth: 8, showLabel: true)
/// ```
public struct PProgressRing: View {
    @Environment(\.pThemeColors) private var theme
    let progress: CGFloat
    let size: CGFloat
    let lineWidth: CGFloat
    let showLabel: Bool
    let labelText: String?

    public init(
        progress: CGFloat,
        size: CGFloat = 60,
        lineWidth: CGFloat = 5,
        showLabel: Bool = false,
        labelText: String? = nil
    ) {
        self.progress = min(max(progress, 0), 1)
        self.size = size
        self.lineWidth = lineWidth
        self.showLabel = showLabel
        self.labelText = labelText
    }

    public var body: some View {
        ZStack {
            // Track
            Circle()
                .stroke(Color.pGlassFill, lineWidth: lineWidth)
                .frame(width: size, height: size)

            // Fill
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    LinearGradient(
                        colors: [theme.accentPrimary, theme.accentSecondary],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                )
                .frame(width: size, height: size)
                .rotationEffect(.degrees(-90))
                .animation(PAnimation.spring, value: progress)

            // Label
            if showLabel {
                Text(labelText ?? "\(Int(progress * 100))%")
                    .font(.system(size: size * 0.22, weight: .semibold))
                    .foregroundStyle(Color.pTextPrimary)
            }
        }
    }
}

// MARK: - Preview

#Preview("PProgressRing") {
    PProgressRingPreviewWrapper()
}

private struct PProgressRingPreviewWrapper: View {
    @State private var progress: CGFloat = 0.72

    var body: some View {
        ZStack {
            PGradientBackground()
            VStack(spacing: PSpacing.xxl) {
                HStack(spacing: PSpacing.xxl) {
                    PProgressRing(progress: 0.3, size: 48)
                    PProgressRing(progress: 0.6, size: 60, showLabel: true)
                    PProgressRing(progress: 0.9, size: 80, lineWidth: 8, showLabel: true)
                }

                PProgressRing(progress: progress, size: 120, lineWidth: 10, showLabel: true)
                Slider(value: $progress).tint(Color.pTextTertiary).padding(.horizontal, PSpacing.xl)
            }
        }
    }
}
