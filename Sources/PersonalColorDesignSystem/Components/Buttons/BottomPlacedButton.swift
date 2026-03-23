import SwiftUI

// MARK: - BottomPlacedButton

/// 화면 하단에 고정되는 주요 액션 버튼.
///
/// 단독 사용:
/// ```swift
/// ContentView()
///     .bottomButtons {
///         BottomPlacedButton(title: "다음") { }
///     }
/// ```
///
/// 최대 3개 스택:
/// ```swift
/// ContentView()
///     .bottomButtons {
///         BottomPlacedButton(title: "저장") { }
///         BottomPlacedButton(title: "취소", isSecondary: true) { }
///     }
/// ```
public struct BottomPlacedButton: View {
    let title: String
    let isSecondary: Bool
    let isLoading: Bool
    let isDisabled: Bool
    let action: () -> Void

    @Environment(\.pThemeColors) var theme

    public init(
        title: String,
        isSecondary: Bool = false,
        isLoading: Bool = false,
        isDisabled: Bool = false,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.isSecondary = isSecondary
        self.isLoading = isLoading
        self.isDisabled = isDisabled
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            ZStack {
                if isLoading {
                    ProgressView().tint(.white)
                } else {
                    Text(title)
                        .font(.pBodyMedium(16))
                        .foregroundStyle(isSecondary ? theme.accentPrimary : Color.white)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .background(buttonBackground)
        }
        .disabled(isLoading || isDisabled)
        .padding(.horizontal, 20)
    }

    @ViewBuilder
    private var buttonBackground: some View {
        if isDisabled {
            RoundedRectangle(cornerRadius: 14)
                .fill(theme.textTertiary.opacity(0.4))
        } else if isSecondary {
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.clear)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .strokeBorder(theme.glassBorder, lineWidth: 1)
                )
        } else {
            RoundedRectangle(cornerRadius: 14)
                .fill(
                    LinearGradient(
                        colors: [theme.accentPrimary, theme.accentSecondary],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
        }
    }
}

// MARK: - Container Modifier

public extension View {
    /// 하단에 버튼을 고정 배치. 노치/홈바 safe area 자동 대응.
    func bottomButtons<Buttons: View>(@ViewBuilder buttons: () -> Buttons) -> some View {
        safeAreaInset(edge: .bottom) {
            VStack(spacing: 10) {
                buttons()
            }
            .padding(.vertical, 12)
        }
    }
}

// MARK: - Preview

#Preview("BottomPlacedButton") {
    BottomButtonPreviewWrapper()
}

private struct BottomButtonPreviewWrapper: View {
    @State private var isLoading = false

    var body: some View {
        ZStack {
            PGradientBackground()
            Text("콘텐츠 영역").foregroundStyle(Color.pTextSecondary)
        }
        .bottomButtons {
            BottomPlacedButton(title: isLoading ? "" : "다음", isLoading: isLoading) {
                isLoading = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) { isLoading = false }
            }
            BottomPlacedButton(title: "취소", isSecondary: true) {}
        }
    }
}
