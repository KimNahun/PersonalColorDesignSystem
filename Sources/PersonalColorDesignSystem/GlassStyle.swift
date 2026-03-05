import UIKit

// MARK: - Glass Morphism Helpers

public extension UIView {

    /// Apply standard glass card style to any UIView
    func applyGlassStyle(cornerRadius: CGFloat = 16) {
        backgroundColor = .pGlassFill
        layer.cornerRadius = cornerRadius
        layer.borderWidth = 1
        layer.borderColor = UIColor.pGlassBorder.cgColor
        layer.shadowColor = UIColor.pShadow.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 12
        layer.shadowOpacity = 1
        clipsToBounds = false
    }

    /// Apply background gradient to view — call in viewDidLayoutSubviews
    func applyBackgroundGradient() {
        layer.sublayers?
            .filter { $0.name == "pBackgroundGradient" }
            .forEach { $0.removeFromSuperlayer() }

        let gradient = UIColor.pBackgroundGradient(frame: bounds)
        gradient.name = "pBackgroundGradient"
        layer.insertSublayer(gradient, at: 0)
    }
}
