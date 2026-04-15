import SwiftUI

// MARK: - PDivider

/// 수평/수직 구분선. 선택적 레이블 표시.
///
/// ```swift
/// PDivider()
/// PDivider(label: "또는")
/// PDivider(axis: .vertical)
/// ```
public struct PDivider: View {
    public enum Axis { case horizontal, vertical }

    let axis: Axis
    let label: String?
    let color: Color?

    public init(
        axis: Axis = .horizontal,
        label: String? = nil,
        color: Color? = nil
    ) {
        self.axis = axis
        self.label = label
        self.color = color
    }

    private var lineColor: Color { color ?? Color.pGlassBorder }

    public var body: some View {
        switch axis {
        case .horizontal:
            if let label {
                HStack(spacing: PSpacing.sm) {
                    line
                    Text(label)
                        .font(.pCaption(12))
                        .foregroundStyle(Color.pTextTertiary)
                    line
                }
            } else {
                line
            }
        case .vertical:
            line
        }
    }

    @ViewBuilder
    private var line: some View {
        switch axis {
        case .horizontal:
            lineColor
                .frame(maxWidth: .infinity, maxHeight: PBorder.hairline)
        case .vertical:
            lineColor
                .frame(maxWidth: PBorder.hairline, maxHeight: .infinity)
        }
    }
}

// MARK: - Preview

#Preview("PDivider") {
    ZStack {
        PGradientBackground()
        VStack(spacing: PSpacing.xxl) {
            VStack(spacing: PSpacing.md) {
                Text("기본").font(.pCaption(12)).foregroundStyle(Color.pTextTertiary).textCase(.uppercase)
                PDivider()
            }

            VStack(spacing: PSpacing.md) {
                Text("레이블 포함").font(.pCaption(12)).foregroundStyle(Color.pTextTertiary).textCase(.uppercase)
                PDivider(label: "또는")
            }

            VStack(spacing: PSpacing.md) {
                Text("수직선").font(.pCaption(12)).foregroundStyle(Color.pTextTertiary).textCase(.uppercase)
                HStack {
                    Text("왼쪽").foregroundStyle(Color.pTextSecondary).font(.pBody(14))
                    PDivider(axis: .vertical)
                        .frame(height: 20)
                    Text("오른쪽").foregroundStyle(Color.pTextSecondary).font(.pBody(14))
                }
            }
        }
        .padding(PSpacing.xl)
    }
}
