import SwiftUI

// MARK: - Shimmer Modifier

/// 어떤 뷰에도 shimmer 로딩 효과 적용.
///
/// ```swift
/// RoundedRectangle(cornerRadius: PRadius.md)
///     .fill(Color.pGlassFill)
///     .frame(height: 20)
///     .shimmer()
/// ```
public struct ShimmerModifier: ViewModifier {
    @State private var phase: CGFloat = -1
    let isActive: Bool

    public func body(content: Content) -> some View {
        if isActive {
            content
                .overlay(
                    GeometryReader { geo in
                        LinearGradient(
                            colors: [
                                Color.white.opacity(0),
                                Color.white.opacity(0.12),
                                Color.white.opacity(0),
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        .frame(width: geo.size.width * 2)
                        .offset(x: phase * geo.size.width * 2)
                    }
                )
                .clipped()
                .onAppear {
                    withAnimation(
                        .linear(duration: 1.4).repeatForever(autoreverses: false)
                    ) {
                        phase = 1
                    }
                }
        } else {
            content
        }
    }
}

public extension View {
    func shimmer(isActive: Bool = true) -> some View {
        modifier(ShimmerModifier(isActive: isActive))
    }
}

// MARK: - PSkeletonLoader

/// shimmer 애니메이션 스켈레톤 플레이스홀더.
/// text/card/list 프리셋 제공.
///
/// ```swift
/// PSkeletonLoader(preset: .text(lines: 3))
/// PSkeletonLoader(preset: .card)
/// PSkeletonLoader(preset: .listRow)
/// ```
public struct PSkeletonLoader: View {
    public enum Preset {
        case text(lines: Int = 3)
        case card
        case listRow
    }

    let preset: Preset

    public init(preset: Preset = .text()) {
        self.preset = preset
    }

    public var body: some View {
        switch preset {
        case .text(let lines):
            VStack(alignment: .leading, spacing: PSpacing.sm) {
                ForEach(0..<lines, id: \.self) { i in
                    skeletonBlock(
                        height: 14,
                        width: i == lines - 1 ? 0.6 : 1.0,
                        radius: PRadius.xs
                    )
                }
            }

        case .card:
            VStack(alignment: .leading, spacing: PSpacing.md) {
                skeletonBlock(height: 140, width: 1.0, radius: PRadius.lg)
                skeletonBlock(height: 16, width: 0.7, radius: PRadius.xs)
                skeletonBlock(height: 12, width: 0.5, radius: PRadius.xs)
            }

        case .listRow:
            HStack(spacing: PSpacing.md) {
                skeletonBlock(height: 34, width: nil, radius: PRadius.sm)
                    .frame(width: 34)
                VStack(alignment: .leading, spacing: PSpacing.xs) {
                    skeletonBlock(height: 14, width: 0.5, radius: PRadius.xs)
                    skeletonBlock(height: 11, width: 0.35, radius: PRadius.xs)
                }
                Spacer()
            }
        }
    }

    private func skeletonBlock(height: CGFloat, width: CGFloat?, radius: CGFloat) -> some View {
        GeometryReader { geo in
            RoundedRectangle(cornerRadius: radius)
                .fill(Color.pGlassFill)
                .frame(
                    width: width != nil ? geo.size.width * width! : nil,
                    height: height
                )
                .shimmer()
        }
        .frame(height: height)
    }
}

// MARK: - Preview

#Preview("PSkeletonLoader") {
    ZStack {
        PGradientBackground()
        ScrollView {
            VStack(alignment: .leading, spacing: PSpacing.xxl) {
                Text("텍스트").font(.pCaption(12)).foregroundStyle(Color.pTextTertiary).textCase(.uppercase)
                PSkeletonLoader(preset: .text(lines: 4))

                Text("카드").font(.pCaption(12)).foregroundStyle(Color.pTextTertiary).textCase(.uppercase)
                PSkeletonLoader(preset: .card)

                Text("리스트").font(.pCaption(12)).foregroundStyle(Color.pTextTertiary).textCase(.uppercase)
                VStack(spacing: PSpacing.md) {
                    ForEach(0..<3, id: \.self) { _ in
                        PSkeletonLoader(preset: .listRow)
                    }
                }
            }
            .padding(PSpacing.xl)
        }
    }
}
