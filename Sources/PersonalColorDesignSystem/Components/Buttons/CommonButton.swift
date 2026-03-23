import SwiftUI

// MARK: - CommonButton

/// 앱 전반에 쓰이는 범용 버튼.
///
/// ```swift
/// CommonButton(title: "확인", style: .filled, action: { })
/// CommonButton(title: "취소", style: .outlined, size: .small, action: { })
/// ```
public struct CommonButton: View {

    public enum Style { case filled, outlined, ghost }
    public enum Size {
        case small, medium

        var height: CGFloat { self == .small ? 32 : 40 }
        var font: Font { self == .small ? .pCaption(13) : .pBodyMedium(15) }
        var horizontalPadding: CGFloat { self == .small ? 12 : 16 }
        var cornerRadius: CGFloat { self == .small ? 8 : 10 }
    }

    let title: String
    let style: Style
    let size: Size
    let action: () -> Void

    @Environment(\.pThemeColors) var theme

    public init(
        title: String,
        style: Style = .filled,
        size: Size = .medium,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.style = style
        self.size = size
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            Text(title)
                .font(size.font)
                .foregroundStyle(foregroundColor)
                .padding(.horizontal, size.horizontalPadding)
                .frame(height: size.height)
                .background(background)
        }
    }

    private var foregroundColor: Color {
        switch style {
        case .filled:           return .white
        case .outlined, .ghost: return theme.accentPrimary
        }
    }

    @ViewBuilder
    private var background: some View {
        if style == .filled {
            RoundedRectangle(cornerRadius: size.cornerRadius)
                .fill(theme.accentPrimary)
        } else if style == .outlined {
            RoundedRectangle(cornerRadius: size.cornerRadius)
                .fill(Color.clear)
                .overlay(
                    RoundedRectangle(cornerRadius: size.cornerRadius)
                        .strokeBorder(theme.glassBorder, lineWidth: 1)
                )
        } else {
            Color.clear
        }
    }
}

// MARK: - Preview

#Preview("CommonButton") {
    ZStack {
        PGradientBackground()

        VStack(spacing: 28) {
            VStack(alignment: .leading, spacing: 12) {
                Text("Medium").font(.pCaption(12)).foregroundStyle(Color.pTextTertiary).textCase(.uppercase)
                HStack(spacing: 10) {
                    CommonButton(title: "Filled", style: .filled, action: {})
                    CommonButton(title: "Outlined", style: .outlined, action: {})
                    CommonButton(title: "Ghost", style: .ghost, action: {})
                }
            }

            VStack(alignment: .leading, spacing: 12) {
                Text("Small").font(.pCaption(12)).foregroundStyle(Color.pTextTertiary).textCase(.uppercase)
                HStack(spacing: 10) {
                    CommonButton(title: "Filled", style: .filled, size: .small, action: {})
                    CommonButton(title: "Outlined", style: .outlined, size: .small, action: {})
                    CommonButton(title: "Ghost", style: .ghost, size: .small, action: {})
                }
            }
        }
        .padding()
    }
}
