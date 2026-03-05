import UIKit
import SwiftUI

// MARK: - Haptic Manager

/// Centralized haptic feedback manager.
///
/// ```swift
/// HapticManager.impact()
/// HapticManager.impact(.heavy)
/// HapticManager.notification(.success)
/// HapticManager.selection()
/// ```
public enum HapticManager {

    /// Impact feedback — tap, button press etc.
    public static func impact(_ style: UIImpactFeedbackGenerator.FeedbackStyle = .medium) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.prepare()
        generator.impactOccurred()
    }

    /// Notification feedback — success, warning, error.
    public static func notification(_ type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(type)
    }

    /// Selection changed feedback — picker, toggle etc.
    public static func selection() {
        let generator = UISelectionFeedbackGenerator()
        generator.prepare()
        generator.selectionChanged()
    }
}

// MARK: - SwiftUI Haptic Helpers

public extension View {
    /// Trigger impact haptic on tap.
    func hapticOnTap(_ style: UIImpactFeedbackGenerator.FeedbackStyle = .medium) -> some View {
        simultaneousGesture(
            TapGesture().onEnded { _ in HapticManager.impact(style) }
        )
    }
}
