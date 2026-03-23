import SwiftUI

// MARK: - SwiftUI Gradient Background

public struct PGradientBackground: View {
    @Environment(\.pThemeColors) var theme
    public init() {}

    public var body: some View {
        LinearGradient(
            colors: [theme.backgroundTop, theme.backgroundMid, theme.backgroundBottom],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
}

// MARK: - View Modifier

struct GradientBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            PGradientBackground()
            content
        }
    }
}

public extension View {
    func pGradientBackground() -> some View {
        modifier(GradientBackgroundModifier())
    }
}

// MARK: - Accent Gradient Shape

public struct PAccentGradient: View {
    @Environment(\.pThemeColors) var theme
    public var direction: Axis = .horizontal
    public init(direction: Axis = .horizontal) { self.direction = direction }

    public var body: some View {
        LinearGradient(
            colors: [theme.accentPrimary, theme.accentSecondary],
            startPoint: direction == .horizontal ? .leading : .top,
            endPoint: direction == .horizontal ? .trailing : .bottom
        )
    }
}
