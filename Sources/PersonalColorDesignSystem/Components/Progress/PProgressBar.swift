import SwiftUI

// MARK: - PProgressBar

/// 선형 진행률 바. 결정(determinate)/불확정(indeterminate) 지원.
///
/// ```swift
/// // 결정 진행률 (0.0 ~ 1.0)
/// PProgressBar(progress: 0.6)
/// PProgressBar(progress: $uploadProgress, height: 6, showLabel: true)
///
/// // 불확정 (로딩 중)
/// PProgressBar(isIndeterminate: true)
/// ```
public struct PProgressBar: View {
    @Environment(\.pThemeColors) private var theme
    let progress: CGFloat?
    let isIndeterminate: Bool
    let height: CGFloat
    let showLabel: Bool
    let trackColor: Color?

    @State private var indeterminateOffset: CGFloat = -1

    public init(
        progress: CGFloat,
        height: CGFloat = 4,
        showLabel: Bool = false,
        trackColor: Color? = nil
    ) {
        self.progress = min(max(progress, 0), 1)
        self.isIndeterminate = false
        self.height = height
        self.showLabel = showLabel
        self.trackColor = trackColor
    }

    public init(
        isIndeterminate: Bool = true,
        height: CGFloat = 4,
        trackColor: Color? = nil
    ) {
        self.progress = nil
        self.isIndeterminate = isIndeterminate
        self.height = height
        self.showLabel = false
        self.trackColor = trackColor
    }

    public var body: some View {
        VStack(alignment: .trailing, spacing: PSpacing.xs) {
            if showLabel, let progress {
                Text("\(Int(progress * 100))%")
                    .font(.pCaption(12))
                    .foregroundStyle(Color.pTextTertiary)
            }

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    // Track
                    Capsule()
                        .fill(trackColor ?? Color.pGlassFill)
                        .frame(height: height)

                    // Fill
                    if isIndeterminate {
                        Capsule()
                            .fill(
                                LinearGradient(
                                    colors: [theme.accentPrimary.opacity(0), theme.accentPrimary, theme.accentPrimary.opacity(0)],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(width: geo.size.width * 0.4, height: height)
                            .offset(x: indeterminateOffset * geo.size.width)
                            .onAppear {
                                withAnimation(.linear(duration: 1.2).repeatForever(autoreverses: false)) {
                                    indeterminateOffset = 1.6
                                }
                            }
                    } else if let progress {
                        Capsule()
                            .fill(
                                LinearGradient(
                                    colors: [theme.accentPrimary, theme.accentSecondary],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(width: geo.size.width * progress, height: height)
                            .animation(PAnimation.spring, value: progress)
                    }
                }
            }
            .frame(height: height)
        }
    }
}

// MARK: - Preview

#Preview("PProgressBar") {
    PProgressBarPreviewWrapper()
}

private struct PProgressBarPreviewWrapper: View {
    @State private var progress: CGFloat = 0.6

    var body: some View {
        ZStack {
            PGradientBackground()
            VStack(alignment: .leading, spacing: PSpacing.xxl) {
                Text("결정 진행률").font(.pCaption(12)).foregroundStyle(Color.pTextTertiary).textCase(.uppercase)
                PProgressBar(progress: progress, showLabel: true)
                Slider(value: $progress).tint(Color.pTextTertiary)

                Text("굵은 바").font(.pCaption(12)).foregroundStyle(Color.pTextTertiary).textCase(.uppercase)
                PProgressBar(progress: 0.35, height: 8)

                Text("불확정").font(.pCaption(12)).foregroundStyle(Color.pTextTertiary).textCase(.uppercase)
                PProgressBar(isIndeterminate: true, height: 4)
            }
            .padding(PSpacing.xl)
        }
    }
}
