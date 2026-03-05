import UIKit

// MARK: - UIKit Typography Tokens

public extension UIFont {

    /// Large time/number display — light
    static func pDisplay(_ size: CGFloat) -> UIFont {
        .systemFont(ofSize: size, weight: .light)
    }

    /// Section title — semibold
    static func pTitle(_ size: CGFloat) -> UIFont {
        .systemFont(ofSize: size, weight: .semibold)
    }

    /// Emphasized body — medium
    static func pBodyMedium(_ size: CGFloat) -> UIFont {
        .systemFont(ofSize: size, weight: .medium)
    }

    /// Regular body
    static func pBody(_ size: CGFloat) -> UIFont {
        .systemFont(ofSize: size, weight: .regular)
    }

    /// Caption / label
    static func pCaption(_ size: CGFloat) -> UIFont {
        .systemFont(ofSize: size, weight: .regular)
    }
}
