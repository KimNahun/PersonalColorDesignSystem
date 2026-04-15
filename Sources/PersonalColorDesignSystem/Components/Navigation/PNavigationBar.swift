import SwiftUI

// MARK: - PNavigationBar

/// 커스텀 네비게이션 헤더.
/// `.pNavigationBar()` modifier로 뷰 상단에 고정.
///
/// ```swift
/// ContentView()
///     .pNavigationBar(title: "설정")
///
/// ContentView()
///     .pNavigationBar(title: "프로필", onBack: { dismiss() }) {
///         Button("저장") { save() }
///     }
/// ```
public struct PNavigationBar<Trailing: View>: View {
    @Environment(\.pThemeColors) private var theme
    let title: String
    let onBack: (() -> Void)?
    let trailing: Trailing

    public init(
        title: String,
        onBack: (() -> Void)? = nil,
        @ViewBuilder trailing: () -> Trailing
    ) {
        self.title = title
        self.onBack = onBack
        self.trailing = trailing()
    }

    public var body: some View {
        HStack {
            if let onBack {
                Button(action: onBack) {
                    HStack(spacing: PSpacing.xs) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 16, weight: .semibold))
                        Text("뒤로")
                            .font(.pBody(16))
                    }
                    .foregroundStyle(theme.accentPrimary)
                }
            }

            Spacer()

            Text(title)
                .font(.pBodyMedium(17))
                .foregroundStyle(Color.pTextPrimary)

            Spacer()

            trailing
                .font(.pBody(16))
                .foregroundStyle(theme.accentPrimary)
        }
        .padding(.horizontal, PSpacing.xl)
        .frame(height: 44)
        .background(
            Color.pTabBarBackground
                .overlay(alignment: .bottom) {
                    PDivider().padding(.horizontal, 0)
                }
        )
    }
}

public extension PNavigationBar where Trailing == EmptyView {
    init(title: String, onBack: (() -> Void)? = nil) {
        self.init(title: title, onBack: onBack, trailing: { EmptyView() })
    }
}

// MARK: - View Modifier

private struct PNavigationBarModifier<Trailing: View>: ViewModifier {
    let title: String
    let onBack: (() -> Void)?
    let trailing: Trailing

    func body(content: Content) -> some View {
        VStack(spacing: 0) {
            PNavigationBar(title: title, onBack: onBack) { trailing }
            content
        }
    }
}

public extension View {
    func pNavigationBar<T: View>(
        title: String,
        onBack: (() -> Void)? = nil,
        @ViewBuilder trailing: () -> T
    ) -> some View {
        modifier(PNavigationBarModifier(title: title, onBack: onBack, trailing: trailing()))
    }

    func pNavigationBar(title: String, onBack: (() -> Void)? = nil) -> some View {
        pNavigationBar(title: title, onBack: onBack, trailing: { EmptyView() })
    }
}

// MARK: - Preview

#Preview("PNavigationBar") {
    ZStack {
        PGradientBackground()
        VStack(spacing: 0) {
            PNavigationBar(title: "설정", onBack: {})
            PNavigationBar(title: "프로필", onBack: {}) {
                Button("저장") {}
            }
            PNavigationBar(title: "홈")
            Spacer()
        }
    }
    .ignoresSafeArea(edges: .top)
}
