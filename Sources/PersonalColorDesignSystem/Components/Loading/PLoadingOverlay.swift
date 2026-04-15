import SwiftUI

// MARK: - PLoadingOverlay

/// 전체화면 dim + ProgressView 로딩 오버레이.
///
/// ```swift
/// ContentView()
///     .pLoadingOverlay(isLoading: $isLoading)
///
/// ContentView()
///     .pLoadingOverlay(isLoading: $isLoading, message: "업로드 중...")
/// ```
public struct PLoadingOverlay: View {
    @Environment(\.pThemeColors) private var theme
    let message: String?

    public init(message: String? = nil) {
        self.message = message
    }

    public var body: some View {
        ZStack {
            Color.black.opacity(0.55)
                .ignoresSafeArea()

            VStack(spacing: PSpacing.md) {
                ProgressView()
                    .progressViewStyle(.circular)
                    .tint(theme.accentPrimary)
                    .scaleEffect(1.2)

                if let message {
                    Text(message)
                        .font(.pBody(14))
                        .foregroundStyle(Color.pTextSecondary)
                }
            }
            .padding(PSpacing.xxl)
            .background(
                RoundedRectangle(cornerRadius: PRadius.xl)
                    .fill(Color.pToastBackground)
                    .overlay(
                        RoundedRectangle(cornerRadius: PRadius.xl)
                            .strokeBorder(Color.pGlassBorder, lineWidth: PBorder.hairline)
                    )
            )
            .pShadowHigh()
        }
    }
}

// MARK: - View Modifier

private struct PLoadingOverlayModifier: ViewModifier {
    @Binding var isLoading: Bool
    let message: String?

    func body(content: Content) -> some View {
        ZStack {
            content
            if isLoading {
                PLoadingOverlay(message: message)
                    .transition(.opacity)
            }
        }
        .animation(PAnimation.easeOut, value: isLoading)
    }
}

public extension View {
    func pLoadingOverlay(isLoading: Binding<Bool>, message: String? = nil) -> some View {
        modifier(PLoadingOverlayModifier(isLoading: isLoading, message: message))
    }
}

// MARK: - Preview

#Preview("PLoadingOverlay") {
    PLoadingOverlayPreviewWrapper()
}

private struct PLoadingOverlayPreviewWrapper: View {
    @State private var isLoading = false

    var body: some View {
        ZStack {
            PGradientBackground()
            VStack {
                Text("콘텐츠 영역").foregroundStyle(Color.pTextSecondary).font(.pBody(15))
                BottomPlacedButton(title: "로딩 시작") {
                    isLoading = true
                    Task {
                        try? await Task.sleep(nanoseconds: 2_500_000_000)
                        isLoading = false
                    }
                }
                .padding()
            }
        }
        .pLoadingOverlay(isLoading: $isLoading, message: "처리 중...")
    }
}
