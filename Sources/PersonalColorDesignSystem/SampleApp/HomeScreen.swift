import SwiftUI

// MARK: - Screen 3: Home

#Preview("3. Home") { HomeScreen().pTheme(.winter) }

struct HomeScreen: View {
    @Environment(\.pThemeColors) var theme
    @Environment(PToastManager.self) var toastManager
    @State private var selectedItem: StyleItem? = nil

    var body: some View {
        NavigationView {
            ZStack {
                PGradientBackground()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {

                        // 오늘의 컬러 배너
                        TodayColorBanner()

                        // 빠른 액션
                        VStack(alignment: .leading, spacing: 12) {
                            SectionLabel("빠른 기록")
                            HStack(spacing: 10) {
                                QuickActionButton(icon: "camera.fill", label: "사진 기록")
                                QuickActionButton(icon: "pencil", label: "메모")
                                QuickActionButton(icon: "heart.fill", label: "즐겨찾기")
                                QuickActionButton(icon: "square.grid.2x2", label: "컬렉션")
                            }
                        }

                        // 추천 스타일
                        VStack(alignment: .leading, spacing: 12) {
                            SectionLabel("오늘의 추천")
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    ForEach(StyleItem.samples) { item in
                                        StyleCardSmall(item: item)
                                            .onTapGesture {
                                                selectedItem = item
                                                HapticManager.impact(.light)
                                            }
                                    }
                                }
                                .padding(.horizontal, 20)
                            }
                            .padding(.horizontal, -20)
                        }

                        // 최근 기록
                        VStack(alignment: .leading, spacing: 12) {
                            SectionLabel("최근 기록")
                            GlassCard {
                                EmptyStateView(
                                    icon: "clock.arrow.circlepath",
                                    title: "아직 기록이 없어요",
                                    description: "오늘의 스타일을 기록해보세요.",
                                    actionTitle: "기록 시작",
                                    action: { toastManager.show("준비 중인 기능이에요", type: .info) }
                                )
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                    .padding(.bottom, 32)
                }
            }
            .navigationTitle("안녕하세요 👋")
            .navigationBarTitleDisplayMode(.large)
            .sheet(item: $selectedItem) { item in
                DetailScreen(item: item)
            }
        }
    }
}

// MARK: - Today Color Banner

private struct TodayColorBanner: View {
    @Environment(\.pThemeColors) var theme

    var body: some View {
        GlassCard(cornerRadius: 20) {
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("오늘의 컬러")
                        .font(.pCaption(12))
                        .foregroundStyle(theme.accentPrimary)
                        .textCase(.uppercase)
                    Text("당신은\n\(seasonLabel) 타입")
                        .font(.pTitle(22))
                        .foregroundStyle(Color.pTextPrimary)
                    Text("따뜻하고 생기있는 컬러가\n잘 어울려요")
                        .font(.pBody(13))
                        .foregroundStyle(Color.pTextSecondary)
                }
                Spacer()
                PAccentGradient(direction: .vertical)
                    .frame(width: 80, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
            }
            .padding(20)
        }
    }

    private var seasonLabel: String { "봄" }
}

// MARK: - Quick Action Button

private struct QuickActionButton: View {
    @Environment(\.pThemeColors) var theme
    let icon: String
    let label: String

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .fill(theme.glassFill)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .strokeBorder(theme.glassBorder, lineWidth: 0.5)
                    )
                    .frame(width: 56, height: 56)
                Image(systemName: icon)
                    .foregroundStyle(theme.accentPrimary)
                    .font(.system(size: 20))
            }
            Text(label)
                .font(.pCaption(11))
                .foregroundStyle(Color.pTextSecondary)
        }
        .frame(maxWidth: .infinity)
        .hapticOnTap(.light)
    }
}

// MARK: - Style Card (Small)

private struct StyleCardSmall: View {
    @Environment(\.pThemeColors) var theme
    let item: StyleItem

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(theme.accentPrimary.opacity(0.15))
                    .frame(width: 130, height: 90)
                Image(systemName: item.icon)
                    .font(.system(size: 32, weight: .light))
                    .foregroundStyle(theme.accentPrimary)
            }
            VStack(alignment: .leading, spacing: 2) {
                Text(item.name)
                    .font(.pBodyMedium(13))
                    .foregroundStyle(Color.pTextPrimary)
                Text(item.category)
                    .font(.pCaption(11))
                    .foregroundStyle(Color.pTextTertiary)
            }
            .padding(.horizontal, 4)
        }
        .frame(width: 130)
        .padding(.bottom, 10)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(theme.glassFill)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .strokeBorder(theme.glassBorder, lineWidth: 0.5)
                )
        )
    }
}

// MARK: - Shared Helpers

struct SectionLabel: View {
    let title: String
    init(_ title: String) { self.title = title }

    var body: some View {
        Text(title)
            .font(.pTitle(17))
            .foregroundStyle(Color.pTextPrimary)
    }
}

// MARK: - Data Model

struct StyleItem: Identifiable {
    let id = UUID()
    let name: String
    let category: String
    let icon: String
    let description: String

    static let samples: [StyleItem] = [
        StyleItem(name: "캐주얼 룩", category: "일상", icon: "tshirt.fill",
                  description: "편안하고 자연스러운 일상 코디. 소프트한 컬러와 루즈핏이 포인트입니다."),
        StyleItem(name: "오피스 룩", category: "직장", icon: "briefcase.fill",
                  description: "단정하면서도 세련된 오피스 스타일. 중간 채도의 색상을 활용하세요."),
        StyleItem(name: "데이트 룩", category: "특별한 날", icon: "heart.fill",
                  description: "부드럽고 로맨틱한 분위기의 코디. 퍼스널 컬러의 파스텔 계열을 추천합니다."),
        StyleItem(name: "스포츠 룩", category: "운동", icon: "figure.run",
                  description: "활동적이고 생기있는 스포티 스타일. 비비드한 액센트 컬러가 어울려요."),
        StyleItem(name: "포멀 룩", category: "행사", icon: "sparkles",
                  description: "품격있고 우아한 포멀 스타일. 딥 컬러와 골드 액세서리를 활용하세요."),
    ]
}
