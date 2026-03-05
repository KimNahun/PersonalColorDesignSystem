import UIKit

// MARK: - Color Tokens
// Dark mode fixed design system
// Theme: Deep navy/purple background with lavender & pink accents

public extension UIColor {

    // MARK: - Accent

    /// Primary accent — soft lavender/purple
    static let pAccentPrimary = UIColor(red: 0.7, green: 0.5, blue: 1.0, alpha: 1.0)

    /// Secondary accent — soft pink/coral
    static let pAccentSecondary = UIColor(red: 1.0, green: 0.6, blue: 0.7, alpha: 1.0)

    // MARK: - Background

    /// Background gradient top — deep navy
    static let pBackgroundTop = UIColor(red: 0.08, green: 0.08, blue: 0.15, alpha: 1.0)

    /// Background gradient middle — dark purple
    static let pBackgroundMid = UIColor(red: 0.15, green: 0.10, blue: 0.25, alpha: 1.0)

    /// Background gradient bottom — deep blue-purple
    static let pBackgroundBottom = UIColor(red: 0.10, green: 0.12, blue: 0.20, alpha: 1.0)

    // MARK: - Glass Morphism

    /// Glass card fill
    static let pGlassFill = UIColor.white.withAlphaComponent(0.08)

    /// Glass card border
    static let pGlassBorder = UIColor.white.withAlphaComponent(0.15)

    /// Selected/highlighted glass state
    static let pGlassSelected = UIColor.white.withAlphaComponent(0.12)

    // MARK: - Text

    /// Primary text — full white
    static let pTextPrimary = UIColor.white

    /// Secondary text — 70% white
    static let pTextSecondary = UIColor.white.withAlphaComponent(0.7)

    /// Tertiary text — 50% white
    static let pTextTertiary = UIColor.white.withAlphaComponent(0.5)

    // MARK: - Semantic

    /// Success / enabled state — soft green
    static let pSuccess = UIColor(red: 0.5, green: 0.9, blue: 0.7, alpha: 1.0)

    /// Warning / skip state — warm orange
    static let pWarning = UIColor(red: 1.0, green: 0.75, blue: 0.4, alpha: 1.0)

    /// Destructive / error state — soft red-pink
    static let pDestructive = UIColor(red: 1.0, green: 0.45, blue: 0.5, alpha: 1.0)

    // MARK: - Shadow

    /// Card drop shadow
    static let pShadow = UIColor.black.withAlphaComponent(0.4)
}
