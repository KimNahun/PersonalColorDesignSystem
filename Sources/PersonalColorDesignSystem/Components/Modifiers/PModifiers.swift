import SwiftUI

// MARK: - pressable()

/// 탭 시 scale-down + haptic 피드백 modifier.
///
/// ```swift
/// Image(systemName: "heart")
///     .pressable()
///
/// GlassCard { ... }
///     .pressable(scale: 0.97, haptic: .medium)
/// ```
public struct PressableModifier: ButtonStyle {
    let scale: CGFloat
    let haptic: UIImpactFeedbackGenerator.FeedbackStyle

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scale : 1.0)
            .animation(PAnimation.springFast, value: configuration.isPressed)
            .onChange(of: configuration.isPressed) { _, isPressed in
                if isPressed { HapticManager.impact(haptic) }
            }
    }
}

public extension View {
    func pressable(
        scale: CGFloat = 0.95,
        haptic: UIImpactFeedbackGenerator.FeedbackStyle = .light
    ) -> some View {
        buttonStyle(PressableModifier(scale: scale, haptic: haptic))
    }
}

// MARK: - conditionalModifier()

/// 조건부 modifier 체이닝. if 분기 없이 사용.
///
/// ```swift
/// Text("Hello")
///     .conditionalModifier(isSelected) { $0.bold().foregroundStyle(.white) }
/// ```
public extension View {
    @ViewBuilder
    func conditionalModifier<Modified: View>(
        _ condition: Bool,
        transform: (Self) -> Modified
    ) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

// MARK: - pCardShadow()

/// PShadow 토큰 기반 카드 그림자 통일 modifier.
/// GlassCard 등 카드 컴포넌트의 기본 그림자.
///
/// ```swift
/// GlassCard { ... }
///     .pCardShadow()
/// ```
public extension View {
    func pCardShadow() -> some View {
        pShadowLow()
    }
}

// MARK: - pFocusBorder()

/// 포커스/선택 상태 강조 테두리 modifier.
///
/// ```swift
/// PTextField(...)
///     .pFocusBorder(isFocused: isFocused)
/// ```
public extension View {
    func pFocusBorder(isFocused: Bool, theme: PThemeColors? = nil) -> some View {
        overlay(
            RoundedRectangle(cornerRadius: PRadius.md)
                .strokeBorder(
                    isFocused ? Color.pAccentPrimary.opacity(0.7) : Color.clear,
                    lineWidth: PBorder.thick
                )
                .animation(PAnimation.springFast, value: isFocused)
        )
    }
}

// MARK: - Preview

#Preview("PModifiers") {
    ZStack {
        PGradientBackground()
        VStack(spacing: PSpacing.xxl) {
            Text("pressable()").font(.pCaption(12)).foregroundStyle(Color.pTextTertiary).textCase(.uppercase)
            Button("탭해보세요") {}
                .font(.pBodyMedium(15))
                .foregroundStyle(Color.pTextPrimary)
                .padding(.horizontal, PSpacing.xl)
                .frame(height: 44)
                .background(RoundedRectangle(cornerRadius: PRadius.md).fill(Color.pGlassFill))
                .pressable()

            Text("conditionalModifier()").font(.pCaption(12)).foregroundStyle(Color.pTextTertiary).textCase(.uppercase)
            Text("Bold 적용됨")
                .font(.pBody(15))
                .foregroundStyle(Color.pTextPrimary)
                .conditionalModifier(true) { $0.bold() }

            Text("shimmer()").font(.pCaption(12)).foregroundStyle(Color.pTextTertiary).textCase(.uppercase)
            RoundedRectangle(cornerRadius: PRadius.md)
                .fill(Color.pGlassFill)
                .frame(height: 44)
                .shimmer()
        }
        .padding(PSpacing.xl)
    }
}
