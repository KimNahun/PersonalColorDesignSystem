import SwiftUI

// MARK: - PBadgeStyle

public enum PBadgeStyle {
    /// 숫자 뱃지 (최대 99+)
    case count(Int)
    /// 점 뱃지 (읽지 않음 표시)
    case dot
    /// 텍스트 뱃지
    case label(String)
}

// MARK: - PBadge

/// 숫자·dot·텍스트 뱃지 컴포넌트.
/// `.pBadge()` modifier로 다른 뷰 위에 overlay 형태로 사용 권장.
///
/// ```swift
/// // 독립 사용
/// PBadge(style: .count(5))
///
/// // modifier 형태 (아이콘, 아바타 위)
/// Image(systemName: "bell")
///     .pBadge(count: 3)
///
/// Image(systemName: "message")
///     .pBadgeDot()
/// ```
public struct PBadge: View {
    @Environment(\.pThemeColors) private var theme
    let style: PBadgeStyle
    let color: Color?

    public init(style: PBadgeStyle, color: Color? = nil) {
        self.style = style
        self.color = color
    }

    public var body: some View {
        switch style {
        case .dot:
            Circle()
                .fill(color ?? theme.destructive)
                .frame(width: 8, height: 8)
                .pShadowLow()

        case .count(let n):
            Text(n > 99 ? "99+" : "\(n)")
                .font(.system(size: 10, weight: .bold))
                .foregroundStyle(.white)
                .padding(.horizontal, n > 9 ? PSpacing.xs : 0)
                .frame(minWidth: 18, minHeight: 18)
                .background(
                    Capsule()
                        .fill(color ?? theme.destructive)
                )
                .pShadowLow()

        case .label(let text):
            Text(text)
                .font(.system(size: 10, weight: .bold))
                .foregroundStyle(.white)
                .padding(.horizontal, PSpacing.xs)
                .frame(height: 18)
                .background(
                    Capsule()
                        .fill(color ?? theme.accentPrimary)
                )
                .pShadowLow()
        }
    }
}

// MARK: - View Modifier

public extension View {
    /// 숫자 뱃지를 우상단에 overlay.
    func pBadge(count: Int, color: Color? = nil) -> some View {
        overlay(alignment: .topTrailing) {
            if count > 0 {
                PBadge(style: .count(count), color: color)
                    .offset(x: 6, y: -6)
                    .transition(.scale.combined(with: .opacity))
            }
        }
        .animation(PAnimation.springFast, value: count)
    }

    /// dot 뱃지를 우상단에 overlay.
    func pBadgeDot(color: Color? = nil, isVisible: Bool = true) -> some View {
        overlay(alignment: .topTrailing) {
            if isVisible {
                PBadge(style: .dot, color: color)
                    .offset(x: 3, y: -3)
                    .transition(.scale.combined(with: .opacity))
            }
        }
        .animation(PAnimation.springFast, value: isVisible)
    }
}

// MARK: - Preview

#Preview("PBadge") {
    ZStack {
        PGradientBackground()
        VStack(spacing: PSpacing.xxxl) {
            HStack(spacing: PSpacing.xxl) {
                Image(systemName: "bell.fill")
                    .font(.system(size: 28))
                    .foregroundStyle(Color.pTextPrimary)
                    .pBadge(count: 3)

                Image(systemName: "message.fill")
                    .font(.system(size: 28))
                    .foregroundStyle(Color.pTextPrimary)
                    .pBadge(count: 128)

                Image(systemName: "person.fill")
                    .font(.system(size: 28))
                    .foregroundStyle(Color.pTextPrimary)
                    .pBadgeDot()
            }

            HStack(spacing: PSpacing.md) {
                PBadge(style: .count(7))
                PBadge(style: .dot)
                PBadge(style: .label("New"))
                PBadge(style: .label("Beta"))
            }
        }
    }
}
