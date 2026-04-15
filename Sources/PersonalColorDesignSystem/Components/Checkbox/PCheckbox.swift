import SwiftUI

// MARK: - PCheckboxState

public enum PCheckboxState {
    case unchecked, checked, indeterminate
}

// MARK: - PCheckbox

/// 체크박스 컴포넌트. checked/unchecked/indeterminate 세 상태 지원.
///
/// ```swift
/// PCheckbox("동의합니다", state: $agreed)
/// PCheckbox("전체 선택", state: .constant(.indeterminate))
/// ```
public struct PCheckbox: View {
    @Environment(\.pThemeColors) private var theme
    let label: String?
    @Binding var state: PCheckboxState
    let isDisabled: Bool

    public init(
        _ label: String? = nil,
        state: Binding<PCheckboxState>,
        isDisabled: Bool = false
    ) {
        self.label = label
        self._state = state
        self.isDisabled = isDisabled
    }

    public var body: some View {
        Button {
            guard !isDisabled else { return }
            HapticManager.impact(.light)
            withAnimation(PAnimation.springFast) {
                state = (state == .checked) ? .unchecked : .checked
            }
        } label: {
            HStack(spacing: PSpacing.sm) {
                checkboxBox
                if let label {
                    Text(label)
                        .font(.pBody(15))
                        .foregroundStyle(isDisabled ? Color.pTextTertiary : Color.pTextPrimary)
                }
            }
        }
        .disabled(isDisabled)
    }

    @ViewBuilder
    private var checkboxBox: some View {
        ZStack {
            RoundedRectangle(cornerRadius: PRadius.xs)
                .fill(boxFill)
                .frame(width: 22, height: 22)
                .overlay(
                    RoundedRectangle(cornerRadius: PRadius.xs)
                        .strokeBorder(boxBorder, lineWidth: PBorder.thin)
                )

            switch state {
            case .checked:
                Image(systemName: "checkmark")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundStyle(.white)
                    .transition(.scale.combined(with: .opacity))
            case .indeterminate:
                Rectangle()
                    .fill(.white)
                    .frame(width: 10, height: 2)
                    .clipShape(RoundedRectangle(cornerRadius: 1))
                    .transition(.scale.combined(with: .opacity))
            case .unchecked:
                EmptyView()
            }
        }
    }

    private var boxFill: Color {
        switch state {
        case .checked, .indeterminate: return isDisabled ? Color.pTextTertiary : theme.accentPrimary
        case .unchecked: return Color.pGlassFill
        }
    }

    private var boxBorder: Color {
        switch state {
        case .checked, .indeterminate: return .clear
        case .unchecked: return isDisabled ? Color.pTextTertiary : Color.pGlassBorder
        }
    }
}

// MARK: - Preview

#Preview("PCheckbox") {
    PCheckboxPreviewWrapper()
}

private struct PCheckboxPreviewWrapper: View {
    @State private var a: PCheckboxState = .unchecked
    @State private var b: PCheckboxState = .checked
    @State private var c: PCheckboxState = .indeterminate

    var body: some View {
        ZStack {
            PGradientBackground()
            VStack(alignment: .leading, spacing: PSpacing.xl) {
                Text("상태별")
                    .font(.pCaption(12)).foregroundStyle(Color.pTextTertiary).textCase(.uppercase)
                VStack(alignment: .leading, spacing: PSpacing.md) {
                    PCheckbox("미선택", state: $a)
                    PCheckbox("선택됨", state: $b)
                    PCheckbox("부분 선택 (indeterminate)", state: $c)
                }

                Text("비활성화")
                    .font(.pCaption(12)).foregroundStyle(Color.pTextTertiary).textCase(.uppercase)
                VStack(alignment: .leading, spacing: PSpacing.md) {
                    PCheckbox("비활성 미선택", state: .constant(.unchecked), isDisabled: true)
                    PCheckbox("비활성 선택됨", state: .constant(.checked), isDisabled: true)
                }
            }
            .padding(PSpacing.xl)
        }
    }
}
