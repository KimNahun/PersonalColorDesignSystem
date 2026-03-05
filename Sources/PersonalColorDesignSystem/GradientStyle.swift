import UIKit

// MARK: - Gradient Helpers

public extension UIColor {

    /// Standard diagonal background gradient (top-left → bottom-right)
    static func pBackgroundGradient(frame: CGRect) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = [
            UIColor.pBackgroundTop.cgColor,
            UIColor.pBackgroundMid.cgColor,
            UIColor.pBackgroundBottom.cgColor,
        ]
        gradient.locations = [0.0, 0.5, 1.0]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        return gradient
    }

    /// Accent gradient — lavender → pink
    static func pAccentGradient(frame: CGRect, direction: GradientDirection = .horizontal) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = [
            UIColor.pAccentPrimary.cgColor,
            UIColor.pAccentSecondary.cgColor,
        ]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = direction.startPoint
        gradient.endPoint = direction.endPoint
        return gradient
    }
}

// MARK: - Gradient Direction

public enum GradientDirection {
    case horizontal
    case vertical
    case diagonal

    var startPoint: CGPoint {
        switch self {
        case .horizontal: return CGPoint(x: 0, y: 0.5)
        case .vertical:   return CGPoint(x: 0.5, y: 0)
        case .diagonal:   return CGPoint(x: 0, y: 0)
        }
    }

    var endPoint: CGPoint {
        switch self {
        case .horizontal: return CGPoint(x: 1, y: 0.5)
        case .vertical:   return CGPoint(x: 0.5, y: 1)
        case .diagonal:   return CGPoint(x: 1, y: 1)
        }
    }
}
