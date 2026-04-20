import SwiftUI

// MARK: - Sample App Entry

#Preview("Palet — Full App") {
    SampleAppView()
}

// MARK: - Root Container

public struct SampleAppView: View {
    @State private var selectedTheme: PTheme = .winter
    @State private var phase: AppPhase = .splash
    @State private var toastManager = PToastManager()

    public init() {}

    enum AppPhase { case splash, themeSelect, main }

    public var body: some View {
        ZStack {
            switch phase {
            case .splash:
                SplashScreen {
                    withAnimation(.easeInOut(duration: 0.5)) { phase = .themeSelect }
                }
            case .themeSelect:
                ThemeSelectScreen(selectedTheme: $selectedTheme) {
                    withAnimation(.easeInOut(duration: 0.4)) { phase = .main }
                }
            case .main:
                MainTabView(selectedTheme: $selectedTheme)
            }
        }
        .pTheme(selectedTheme)
        .environment(toastManager)
        .pGlobalToast(toastManager)
    }
}

// MARK: - Screen 1: Splash

#Preview("1. Splash") { SplashScreen {} .pTheme(.winter) }

struct SplashScreen: View {
    @Environment(\.pThemeColors) var theme
    var onFinish: () -> Void

    @State private var logoScale: CGFloat = 0.7
    @State private var logoOpacity: CGFloat = 0
    @State private var subtitleOpacity: CGFloat = 0

    var body: some View {
        ZStack {
            PGradientBackground()

            VStack(spacing: 20) {
                Spacer()

                // 로고 아이콘
                ZStack {
                    RoundedRectangle(cornerRadius: 28)
                        .fill(theme.glassFill)
                        .overlay(
                            RoundedRectangle(cornerRadius: 28)
                                .strokeBorder(theme.glassBorder, lineWidth: 0.5)
                        )
                        .frame(width: 100, height: 100)

                    PAccentGradient()
                        .mask(
                            Image(systemName: "paintpalette.fill")
                                .font(.system(size: 48))
                        )
                        .frame(width: 56, height: 56)
                }
                .scaleEffect(logoScale)
                .opacity(logoOpacity)

                VStack(spacing: 8) {
                    Text("Palet")
                        .font(.pDisplay(40))
                        .foregroundStyle(Color.pTextPrimary)

                    Text("나만의 컬러를 찾아보세요")
                        .font(.pBody(16))
                        .foregroundStyle(Color.pTextSecondary)
                }
                .opacity(subtitleOpacity)

                Spacer()
                Spacer()
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                logoScale = 1.0
                logoOpacity = 1.0
            }
            withAnimation(.easeOut(duration: 0.5).delay(0.4)) {
                subtitleOpacity = 1.0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                onFinish()
            }
        }
    }
}

// MARK: - Screen 2: Theme Select

#Preview("2. Theme Select") {
    ThemeSelectPreviewWrapper()
}

private struct ThemeSelectPreviewWrapper: View {
    @State private var theme: PTheme = .winter
    var body: some View {
        ThemeSelectScreen(selectedTheme: $theme) {}
            .pTheme(theme)
    }
}

struct ThemeSelectScreen: View {
    @Environment(\.pThemeColors) var theme
    @Binding var selectedTheme: PTheme
    var onFinish: () -> Void

    var body: some View {
        ZStack {
            PGradientBackground()

            VStack(spacing: 0) {
                // 헤더
                VStack(spacing: 10) {
                    Text("당신의 퍼스널 컬러는?")
                        .font(.pDisplay(28))
                        .foregroundStyle(Color.pTextPrimary)
                        .multilineTextAlignment(.center)

                    Text("계절 타입을 선택하면\n앱 전체 색상이 바뀝니다")
                        .font(.pBody(15))
                        .foregroundStyle(Color.pTextSecondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 60)
                .padding(.horizontal, 32)

                Spacer()

                // 테마 카드들
                VStack(spacing: 14) {
                    ForEach(PTheme.allCases) { themeCase in
                        ThemeCard(
                            themeCase: themeCase,
                            isSelected: selectedTheme == themeCase
                        ) {
                            withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                                selectedTheme = themeCase
                            }
                        }
                    }
                }
                .padding(.horizontal, 24)

                Spacer()
            }
        }
        .bottomButtons {
            BottomPlacedButton(title: "시작하기", action: onFinish)
        }
    }
}

private struct ThemeCard: View {
    @Environment(\.pThemeColors) var theme
    let themeCase: PTheme
    let isSelected: Bool
    let action: () -> Void

    private var cardColors: PThemeColors { themeCase.colors }

    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                // 컬러 프리뷰 원
                HStack(spacing: -8) {
                    Circle().fill(cardColors.backgroundTop).frame(width: 28, height: 28)
                    Circle().fill(cardColors.accentPrimary).frame(width: 28, height: 28)
                    Circle().fill(cardColors.accentSecondary).frame(width: 28, height: 28)
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text(themeCase.displayName + " 타입")
                        .font(.pBodyMedium(15))
                        .foregroundStyle(Color.pTextPrimary)
                    Text(themeCase.seasonDescription)
                        .font(.pCaption(12))
                        .foregroundStyle(Color.pTextSecondary)
                }

                Spacer()

                Image(systemName: themeCase.icon)
                    .foregroundStyle(isSelected ? theme.accentPrimary : Color.pTextTertiary)
                    .font(.system(size: 18))
            }
            .padding(.horizontal, 18)
            .frame(height: 68)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(isSelected ? theme.accentPrimary.opacity(0.12) : theme.glassFill)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .strokeBorder(
                                isSelected ? theme.accentPrimary.opacity(0.5) : theme.glassBorder,
                                lineWidth: isSelected ? 1 : 0.5
                            )
                    )
            )
        }
        .hapticOnTap(.light)
    }
}

private extension PTheme {
    var seasonDescription: String {
        switch self {
        case .spring: return "따뜻하고 생기있는 코럴 & 피치"
        case .summer: return "부드럽고 차가운 모브 & 블루"
        case .autumn: return "자연스럽고 깊은 올리브 & 머스타드"
        case .winter: return "시원하고 투명한 아이시 블루 & 민트"
        }
    }
}

// MARK: - Main Tab View

struct MainTabView: View {
    @Binding var selectedTheme: PTheme
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeScreen()
                .tabItem {
                    Label("홈", systemImage: "house.fill")
                }
                .tag(0)

            ExploreScreen()
                .tabItem {
                    Label("탐색", systemImage: "magnifyingglass")
                }
                .tag(1)

            ProfileScreen(selectedTheme: $selectedTheme)
                .tabItem {
                    Label("프로필", systemImage: "person.fill")
                }
                .tag(2)
        }
        .safeAreaInset(edge: .bottom, spacing: 0) {
            Color.clear.frame(height: 10)
        }
    }
}
