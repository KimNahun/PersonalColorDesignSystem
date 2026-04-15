import SwiftUI

// MARK: - PListRow

/// 표준 리스트 행. leading 아이콘/이미지 + title + subtitle + trailing 콘텐츠.
///
/// ```swift
/// // 기본
/// PListRow(icon: "bell.fill", title: "알림")
///
/// // 부제목 + trailing
/// PListRow(icon: "moon.fill", title: "다크 모드", subtitle: "항상 켜기") {
///     PToggle("", isOn: $isDark)
/// }
///
/// // 네비게이션 화살표
/// PListRow(icon: "person.fill", title: "프로필", showChevron: true) { navigate() }
/// ```
public struct PListRow<Trailing: View>: View {
    @Environment(\.pThemeColors) private var theme
    let icon: String?
    let iconColor: Color?
    let title: String
    let subtitle: String?
    let showChevron: Bool
    let onTap: (() -> Void)?
    let trailing: Trailing

    public init(
        icon: String? = nil,
        iconColor: Color? = nil,
        title: String,
        subtitle: String? = nil,
        showChevron: Bool = false,
        onTap: (() -> Void)? = nil,
        @ViewBuilder trailing: () -> Trailing
    ) {
        self.icon = icon
        self.iconColor = iconColor
        self.title = title
        self.subtitle = subtitle
        self.showChevron = showChevron
        self.onTap = onTap
        self.trailing = trailing()
    }

    public var body: some View {
        Button {
            if let onTap {
                HapticManager.impact(.light)
                onTap()
            }
        } label: {
            HStack(spacing: PSpacing.md) {
                // Leading icon
                if let icon {
                    ZStack {
                        RoundedRectangle(cornerRadius: PRadius.sm)
                            .fill((iconColor ?? theme.accentPrimary).opacity(0.15))
                            .frame(width: 34, height: 34)
                        Image(systemName: icon)
                            .font(.system(size: 15, weight: .medium))
                            .foregroundStyle(iconColor ?? theme.accentPrimary)
                    }
                }

                // Title + Subtitle
                VStack(alignment: .leading, spacing: PSpacing.xxs) {
                    Text(title)
                        .font(.pBody(15))
                        .foregroundStyle(Color.pTextPrimary)
                    if let subtitle {
                        Text(subtitle)
                            .font(.pCaption(13))
                            .foregroundStyle(Color.pTextTertiary)
                    }
                }

                Spacer()

                // Trailing
                trailing

                if showChevron {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(Color.pTextTertiary)
                }
            }
            .padding(.vertical, PSpacing.sm)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .disabled(onTap == nil)
    }
}

// MARK: - Convenience init (no trailing)

public extension PListRow where Trailing == EmptyView {
    init(
        icon: String? = nil,
        iconColor: Color? = nil,
        title: String,
        subtitle: String? = nil,
        showChevron: Bool = false,
        onTap: (() -> Void)? = nil
    ) {
        self.init(
            icon: icon,
            iconColor: iconColor,
            title: title,
            subtitle: subtitle,
            showChevron: showChevron,
            onTap: onTap,
            trailing: { EmptyView() }
        )
    }
}

// MARK: - Preview

#Preview("PListRow") {
    PListRowPreviewWrapper()
}

private struct PListRowPreviewWrapper: View {
    @State private var notif = true
    @State private var dark = false

    var body: some View {
        ZStack {
            PGradientBackground()
            ScrollView {
                VStack(spacing: 0) {
                    GlassCard {
                        VStack(spacing: 0) {
                            PListRow(icon: "bell.fill", title: "알림", subtitle: "푸시 알림 설정") {
                                PToggle("", isOn: $notif)
                            }
                            PDivider().padding(.leading, 50)
                            PListRow(icon: "moon.fill", iconColor: Color.purple, title: "다크 모드") {
                                PToggle("", isOn: $dark)
                            }
                            PDivider().padding(.leading, 50)
                            PListRow(
                                icon: "person.fill",
                                iconColor: Color.blue,
                                title: "프로필",
                                subtitle: "이름, 사진 수정",
                                showChevron: true,
                                onTap: {}
                            )
                            PDivider().padding(.leading, 50)
                            PListRow(
                                icon: "shield.fill",
                                iconColor: Color.green,
                                title: "보안",
                                showChevron: true,
                                onTap: {}
                            )
                        }
                    }
                }
                .padding(PSpacing.xl)
            }
        }
    }
}
