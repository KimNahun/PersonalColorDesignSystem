import SwiftUI

// MARK: - SwiftUI Font Tokens

public extension Font {

    /// Large time/number display — light
    static func pDisplay(_ size: CGFloat) -> Font {
        .system(size: size, weight: .light)
    }

    /// Section title — semibold
    static func pTitle(_ size: CGFloat) -> Font {
        .system(size: size, weight: .semibold)
    }

    /// Emphasized body — medium
    static func pBodyMedium(_ size: CGFloat) -> Font {
        .system(size: size, weight: .medium)
    }

    /// Regular body
    static func pBody(_ size: CGFloat) -> Font {
        .system(size: size, weight: .regular)
    }

    /// Caption / label
    static func pCaption(_ size: CGFloat) -> Font {
        .system(size: size, weight: .regular)
    }
}
