import UIKit

// MARK: - UIKit Color Tokens
// prefix `p` to avoid collision with other projects

public extension UIColor {

    // MARK: Accent
    static let pAccentPrimary   = UIColor(red: 0.7,  green: 0.5,  blue: 1.0,  alpha: 1.0) // soft lavender
    static let pAccentSecondary = UIColor(red: 1.0,  green: 0.6,  blue: 0.7,  alpha: 1.0) // soft pink

    // MARK: Background
    static let pBackgroundTop    = UIColor(red: 0.08, green: 0.08, blue: 0.15, alpha: 1.0) // deep navy
    static let pBackgroundMid    = UIColor(red: 0.15, green: 0.10, blue: 0.25, alpha: 1.0) // dark purple
    static let pBackgroundBottom = UIColor(red: 0.10, green: 0.12, blue: 0.20, alpha: 1.0) // deep blue-purple

    // MARK: Glass
    static let pGlassFill     = UIColor.white.withAlphaComponent(0.08)
    static let pGlassBorder   = UIColor.white.withAlphaComponent(0.15)
    static let pGlassSelected = UIColor.white.withAlphaComponent(0.12)

    // MARK: Text
    static let pTextPrimary   = UIColor.white
    static let pTextSecondary = UIColor.white.withAlphaComponent(0.7)
    static let pTextTertiary  = UIColor.white.withAlphaComponent(0.5)

    // MARK: Semantic
    static let pSuccess     = UIColor(red: 0.5, green: 0.9, blue: 0.7,  alpha: 1.0) // soft green
    static let pWarning     = UIColor(red: 1.0, green: 0.75, blue: 0.4, alpha: 1.0) // warm orange
    static let pDestructive = UIColor(red: 1.0, green: 0.45, blue: 0.5, alpha: 1.0) // soft red-pink

    // MARK: Misc
    static let pShadow         = UIColor.black.withAlphaComponent(0.4)
    static let pToastBackground = UIColor(white: 0.1, alpha: 0.95)
    static let pTabBarBackground = UIColor(white: 0.08, alpha: 1.0)
}
