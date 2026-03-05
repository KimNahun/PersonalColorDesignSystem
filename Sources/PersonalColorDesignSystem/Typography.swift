import UIKit

// MARK: - Typography Tokens

public extension UIFont {

    // MARK: - Display

    /// Large time/number display — light weight
    static func pDisplay(_ size: CGFloat) -> UIFont {
        UIFont.systemFont(ofSize: size, weight: .light)
    }

    /// Section title — semibold
    static func pTitle(_ size: CGFloat) -> UIFont {
        UIFont.systemFont(ofSize: size, weight: .semibold)
    }

    // MARK: - Body

    /// Primary body text — medium
    static func pBodyMedium(_ size: CGFloat) -> UIFont {
        UIFont.systemFont(ofSize: size, weight: .medium)
    }

    /// Regular body text
    static func pBody(_ size: CGFloat) -> UIFont {
        UIFont.systemFont(ofSize: size, weight: .regular)
    }

    // MARK: - Caption

    /// Small caption / label
    static func pCaption(_ size: CGFloat) -> UIFont {
        UIFont.systemFont(ofSize: size, weight: .regular)
    }
}
