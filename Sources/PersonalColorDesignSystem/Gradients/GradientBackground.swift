import SwiftUI

// MARK: - SwiftUI Gradient Background

public struct PGradientBackground: View {
    public init() {}

    public var body: some View {
        LinearGradient(
            colors: [.pBackgroundTop, .pBackgroundMid, .pBackgroundBottom],
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
    /// Wraps the view with the standard deep navy/purple gradient background.
    func pGradientBackground() -> some View {
        modifier(GradientBackgroundModifier())
    }
}

// MARK: - Accent Gradient Shape

public struct PAccentGradient: View {
    public var direction: Axis = .horizontal
    public init(direction: Axis = .horizontal) { self.direction = direction }

    public var body: some View {
        LinearGradient(
            colors: [.pAccentPrimary, .pAccentSecondary],
            startPoint: direction == .horizontal ? .leading : .top,
            endPoint: direction == .horizontal ? .trailing : .bottom
        )
    }
}
