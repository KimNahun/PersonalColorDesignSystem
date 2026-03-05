import SwiftUI

// MARK: - SwiftUI GlassCard

/// Container view with glass morphism styling.
///
/// ```swift
/// GlassCard {
///     Text("Hello")
/// }
///
/// // Custom corner radius
/// GlassCard(cornerRadius: 12) {
///     Text("Hello")
/// }
/// ```
public struct GlassCard<Content: View>: View {
    private let cornerRadius: CGFloat
    private let content: Content

    public init(cornerRadius: CGFloat = 20, @ViewBuilder content: () -> Content) {
        self.cornerRadius = cornerRadius
        self.content = content()
    }

    public var body: some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.pGlassFill)
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .strokeBorder(Color.pGlassBorder, lineWidth: 0.5)
                    )
                    .shadow(color: Color.pShadow, radius: 12, x: 0, y: 4)
            )
    }
}

// MARK: - View Modifier variant

struct GlassCardModifier: ViewModifier {
    let cornerRadius: CGFloat

    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.pGlassFill)
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .strokeBorder(Color.pGlassBorder, lineWidth: 0.5)
                    )
                    .shadow(color: Color.pShadow, radius: 12, x: 0, y: 4)
            )
    }
}

public extension View {
    /// Apply glass card background to any view.
    func glassCard(cornerRadius: CGFloat = 20) -> some View {
        modifier(GlassCardModifier(cornerRadius: cornerRadius))
    }
}
