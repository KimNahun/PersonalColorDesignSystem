import SwiftUI

// MARK: - SwiftUI Color Tokens

public extension Color {

    // MARK: Accent
    static let pAccentPrimary   = Color(red: 0.7,  green: 0.5,  blue: 1.0)  // soft lavender
    static let pAccentSecondary = Color(red: 1.0,  green: 0.6,  blue: 0.7)  // soft pink

    // MARK: Background
    static let pBackgroundTop    = Color(red: 0.08, green: 0.08, blue: 0.15)
    static let pBackgroundMid    = Color(red: 0.15, green: 0.10, blue: 0.25)
    static let pBackgroundBottom = Color(red: 0.10, green: 0.12, blue: 0.20)

    // MARK: Glass
    static let pGlassFill     = Color.white.opacity(0.08)
    static let pGlassBorder   = Color.white.opacity(0.15)
    static let pGlassSelected = Color.white.opacity(0.12)

    // MARK: Text
    static let pTextPrimary   = Color.white
    static let pTextSecondary = Color.white.opacity(0.7)
    static let pTextTertiary  = Color.white.opacity(0.5)

    // MARK: Semantic
    static let pSuccess     = Color(red: 0.5, green: 0.9, blue: 0.7)
    static let pWarning     = Color(red: 1.0, green: 0.75, blue: 0.4)
    static let pDestructive = Color(red: 1.0, green: 0.45, blue: 0.5)

    // MARK: Misc
    static let pShadow          = Color.black.opacity(0.4)
    static let pToastBackground = Color(white: 0.1).opacity(0.95)
    static let pTabBarBackground = Color(white: 0.08)
}
