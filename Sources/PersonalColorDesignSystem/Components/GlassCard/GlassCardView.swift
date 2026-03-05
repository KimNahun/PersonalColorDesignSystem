import UIKit

// MARK: - UIKit GlassCardView

/// Drop-in UIView subclass with glass morphism styling.
open class GlassCardView: UIView {

    public var cornerRadius: CGFloat = 20 {
        didSet { updateAppearance() }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        backgroundColor = UIColor(red: 0.15, green: 0.13, blue: 0.22, alpha: 0.9)
        updateAppearance()
    }

    private func updateAppearance() {
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.pGlassBorder.cgColor
    }
}

// MARK: - UIView Glass Extension

public extension UIView {

    /// Apply glass card style (border + shadow) without clipping.
    func applyGlassEffect(cornerRadius: CGFloat = 20) {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.pGlassBorder.cgColor
        layer.shadowColor = UIColor.pShadow.cgColor
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 12
        clipsToBounds = false
    }
}
