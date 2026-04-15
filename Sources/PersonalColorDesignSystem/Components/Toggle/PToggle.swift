import SwiftUI

// MARK: - PToggle

/// 테마 accentPrimary 색상이 적용된 Toggle 래퍼.
///
/// ```swift
/// PToggle("알림 받기", isOn: $isEnabled)
/// PToggle("다크 모드", isOn: $isDark, icon: "moon.fill")
/// ```
public struct PToggle: View {
    @Environment(\.pThemeColors) private var theme
    let label: String
    @Binding var isOn: Bool
    let icon: String?

    public init(
        _ label: String,
        isOn: Binding<Bool>,
        icon: String? = nil
    ) {
        self.label = label
        self._isOn = isOn
        self.icon = icon
    }

    public var body: some View {
        Toggle(isOn: $isOn.animation(PAnimation.spring)) {
            HStack(spacing: PSpacing.sm) {
                if let icon {
                    Image(systemName: icon)
                        .foregroundStyle(isOn ? theme.accentPrimary : Color.pTextTertiary)
                        .font(.system(size: 15))
                        .frame(width: 20)
                        .animation(PAnimation.springFast, value: isOn)
                }
                Text(label)
                    .font(.pBody(15))
                    .foregroundStyle(Color.pTextPrimary)
            }
        }
        .tint(theme.accentPrimary)
    }
}

// MARK: - Preview

#Preview("PToggle") {
    PTogglePreviewWrapper()
}

private struct PTogglePreviewWrapper: View {
    @State private var a = true
    @State private var b = false
    @State private var c = true

    var body: some View {
        ZStack {
            PGradientBackground()
            VStack(spacing: 0) {
                GlassCard {
                    VStack(spacing: 0) {
                        PToggle("알림 받기", isOn: $a, icon: "bell.fill")
                            .padding(.vertical, PSpacing.md)
                        PDivider()
                        PToggle("다크 모드", isOn: $b, icon: "moon.fill")
                            .padding(.vertical, PSpacing.md)
                        PDivider()
                        PToggle("위치 서비스", isOn: $c)
                            .padding(.vertical, PSpacing.md)
                    }
                }
                .padding(PSpacing.xl)
            }
        }
    }
}
