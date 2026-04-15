import SwiftUI

// MARK: - PSegmentedControl

/// 슬라이딩 indicator가 있는 커스텀 세그먼트 컨트롤.
/// iOS 네이티브 SegmentedPickerStyle 대체.
///
/// ```swift
/// PSegmentedControl(
///     options: ["전체", "음악", "스포츠"],
///     selected: $currentTab
/// )
/// ```
public struct PSegmentedControl: View {
    @Environment(\.pThemeColors) private var theme
    let options: [String]
    @Binding var selected: Int
    @Namespace private var animation

    public init(options: [String], selected: Binding<Int>) {
        self.options = options
        self._selected = selected
    }

    public var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(options.enumerated()), id: \.offset) { index, option in
                Button {
                    HapticManager.selection()
                    withAnimation(PAnimation.spring) {
                        selected = index
                    }
                } label: {
                    Text(option)
                        .font(selected == index ? .pBodyMedium(14) : .pBody(14))
                        .foregroundStyle(selected == index ? .white : Color.pTextSecondary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, PSpacing.sm)
                        .background {
                            if selected == index {
                                Capsule()
                                    .fill(theme.accentPrimary)
                                    .matchedGeometryEffect(id: "indicator", in: animation)
                            }
                        }
                }
            }
        }
        .padding(3)
        .background(
            Capsule()
                .fill(Color.pGlassFill)
                .overlay(
                    Capsule()
                        .strokeBorder(Color.pGlassBorder, lineWidth: PBorder.hairline)
                )
        )
    }
}

// MARK: - Preview

#Preview("PSegmentedControl") {
    PSegmentedPreviewWrapper()
}

private struct PSegmentedPreviewWrapper: View {
    @State private var selected1 = 0
    @State private var selected2 = 1

    var body: some View {
        ZStack {
            PGradientBackground()
            VStack(spacing: PSpacing.xxl) {
                PSegmentedControl(options: ["전체", "음악", "스포츠"], selected: $selected1)

                PSegmentedControl(
                    options: ["봄", "여름", "가을", "겨울"],
                    selected: $selected2
                )
            }
            .padding(PSpacing.xl)
        }
    }
}
