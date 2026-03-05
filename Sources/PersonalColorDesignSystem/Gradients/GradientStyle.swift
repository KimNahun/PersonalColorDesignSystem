import UIKit

// MARK: - UIKit Gradient Helpers

public extension UIColor {

    /// Standard diagonal background gradient (top-left → bottom-right)
    static func pBackgroundGradient(frame: CGRect) -> CAGradientLayer {
        let layer = CAGradientLayer()
        layer.frame = frame
        layer.colors = [pBackgroundTop.cgColor, pBackgroundMid.cgColor, pBackgroundBottom.cgColor]
        layer.locations = [0.0, 0.5, 1.0]
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 1, y: 1)
        return layer
    }

    /// Accent gradient — lavender → pink
    static func pAccentGradient(frame: CGRect, direction: GradientDirection = .horizontal) -> CAGradientLayer {
        let layer = CAGradientLayer()
        layer.frame = frame
        layer.colors = [pAccentPrimary.cgColor, pAccentSecondary.cgColor]
        layer.locations = [0.0, 1.0]
        layer.startPoint = direction.startPoint
        layer.endPoint = direction.endPoint
        return layer
    }
}

// MARK: - UIView Gradient Helper

public extension UIView {

    /// Insert background gradient and keep it updated. Call in viewDidLayoutSubviews.
    func applyBackgroundGradient() {
        layer.sublayers?
            .filter { $0.name == "pBackgroundGradient" }
            .forEach { $0.removeFromSuperlayer() }

        let gradient = UIColor.pBackgroundGradient(frame: bounds)
        gradient.name = "pBackgroundGradient"
        layer.insertSublayer(gradient, at: 0)
    }
}

// MARK: - Gradient Direction

public enum GradientDirection {
    case horizontal, vertical, diagonal

    public var startPoint: CGPoint {
        switch self {
        case .horizontal: return CGPoint(x: 0, y: 0.5)
        case .vertical:   return CGPoint(x: 0.5, y: 0)
        case .diagonal:   return CGPoint(x: 0, y: 0)
        }
    }

    public var endPoint: CGPoint {
        switch self {
        case .horizontal: return CGPoint(x: 1, y: 0.5)
        case .vertical:   return CGPoint(x: 0.5, y: 1)
        case .diagonal:   return CGPoint(x: 1, y: 1)
        }
    }
}
