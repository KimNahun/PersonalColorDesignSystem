import SwiftUI

// MARK: - PChipVariant

public enum PChipVariant {
    /// 선택/해제 토글 가능한 칩
    case toggle
    /// 우측 X 버튼으로 제거 가능한 칩
    case removable
    /// 인터랙션 없는 레이블 전용 칩
    case label
}

// MARK: - PChip

/// 태그·필터·카테고리 표현용 칩 컴포넌트.
///
/// ```swift
/// // 토글 칩
/// PChip("SwiftUI", variant: .toggle, isSelected: $selected)
///
/// // 제거 가능 칩
/// PChip("태그", variant: .removable, onRemove: { tags.remove("태그") })
///
/// // 레이블 칩
/// PChip("봄", variant: .label)
/// ```
public struct PChip: View {
    @Environment(\.pThemeColors) private var theme
    let title: String
    let icon: String?
    let variant: PChipVariant
    var isSelected: Binding<Bool>?
    var onRemove: (() -> Void)?

    // MARK: Toggle variant
    public init(
        _ title: String,
        icon: String? = nil,
        variant: PChipVariant = .toggle,
        isSelected: Binding<Bool>
    ) {
        self.title = title
        self.icon = icon
        self.variant = variant
        self.isSelected = isSelected
    }

    // MARK: Removable variant
    public init(
        _ title: String,
        icon: String? = nil,
        onRemove: @escaping () -> Void
    ) {
        self.title = title
        self.icon = icon
        self.variant = .removable
        self.onRemove = onRemove
    }

    // MARK: Label variant
    public init(
        _ title: String,
        icon: String? = nil
    ) {
        self.title = title
        self.icon = icon
        self.variant = .label
    }

    private var selected: Bool { isSelected?.wrappedValue ?? false }

    public var body: some View {
        Group {
            switch variant {
            case .toggle:
                Button {
                    HapticManager.impact(.light)
                    withAnimation(PAnimation.springFast) {
                        isSelected?.wrappedValue.toggle()
                    }
                } label: { chipContent }

            case .removable:
                chipContent

            case .label:
                chipContent
            }
        }
    }

    private var chipContent: some View {
        HStack(spacing: PSpacing.xs) {
            if let icon {
                Image(systemName: icon)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(selected ? .white : theme.accentPrimary)
            }

            Text(title)
                .font(.pCaption(13))
                .foregroundStyle(selected ? .white : Color.pTextPrimary)

            if variant == .removable {
                Button {
                    HapticManager.impact(.light)
                    onRemove?()
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundStyle(Color.pTextTertiary)
                }
            }
        }
        .padding(.horizontal, PSpacing.md)
        .padding(.vertical, PSpacing.xs + 2)
        .background(
            Capsule()
                .fill(selected ? theme.accentPrimary : Color.pGlassFill)
                .overlay(
                    Capsule()
                        .strokeBorder(
                            selected ? theme.accentPrimary : Color.pGlassBorder,
                            lineWidth: PBorder.hairline
                        )
                )
        )
        .animation(PAnimation.springFast, value: selected)
    }
}

// MARK: - Preview

#Preview("PChip") {
    PChipPreviewWrapper()
}

private struct PChipPreviewWrapper: View {
    @State private var selectedA = false
    @State private var selectedB = true
    @State private var selectedC = false
    @State private var tags = ["SwiftUI", "iOS", "디자인시스템"]

    var body: some View {
        ZStack {
            PGradientBackground()
            ScrollView {
                VStack(alignment: .leading, spacing: PSpacing.xxl) {
                    VStack(alignment: .leading, spacing: PSpacing.sm) {
                        Text("토글 칩").font(.pCaption(12)).foregroundStyle(Color.pTextTertiary).textCase(.uppercase)
                        HStack(spacing: PSpacing.sm) {
                            PChip("봄", icon: "leaf", variant: .toggle, isSelected: $selectedA)
                            PChip("여름", icon: "sun.max", variant: .toggle, isSelected: $selectedB)
                            PChip("겨울", icon: "snowflake", variant: .toggle, isSelected: $selectedC)
                        }
                    }

                    VStack(alignment: .leading, spacing: PSpacing.sm) {
                        Text("제거 가능").font(.pCaption(12)).foregroundStyle(Color.pTextTertiary).textCase(.uppercase)
                        HStack(spacing: PSpacing.sm) {
                            ForEach(tags, id: \.self) { tag in
                                PChip(tag, onRemove: { tags.removeAll { $0 == tag } })
                            }
                        }
                    }

                    VStack(alignment: .leading, spacing: PSpacing.sm) {
                        Text("레이블").font(.pCaption(12)).foregroundStyle(Color.pTextTertiary).textCase(.uppercase)
                        HStack(spacing: PSpacing.sm) {
                            PChip("New", icon: "sparkles")
                            PChip("Beta")
                            PChip("추천", icon: "star.fill")
                        }
                    }
                }
                .padding(PSpacing.xl)
            }
        }
    }
}
