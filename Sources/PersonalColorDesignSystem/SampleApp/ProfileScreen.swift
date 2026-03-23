import SwiftUI

// MARK: - Screen 6: Profile

#Preview("6. Profile") {
    ProfilePreviewWrapper()
}

private struct ProfilePreviewWrapper: View {
    @State private var theme: PTheme = .winter
    var body: some View {
        ProfileScreen(selectedTheme: $theme).pTheme(theme)
    }
}

struct ProfileScreen: View {
    @Environment(\.pThemeColors) var theme
    @Binding var selectedTheme: PTheme
    @State private var showWithdrawModal = false
    @State private var showSavedToast = false

    var body: some View {
        NavigationView {
            ZStack {
                PGradientBackground()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {

                        // 프로필 카드
                        ProfileCard()

                        // 테마 변경
                        GlassCard {
                            VStack(alignment: .leading, spacing: 14) {
                                Label("퍼스널 컬러 테마", systemImage: "paintpalette")
                                    .font(.pCaption(12))
                                    .foregroundStyle(Color.pTextTertiary)
                                    .textCase(.uppercase)

                                HStack(spacing: 8) {
                                    ForEach(PTheme.allCases) { themeCase in
                                        Button {
                                            withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                                                selectedTheme = themeCase
                                            }
                                            HapticManager.selection()
                                            showSavedToast = true
                                        } label: {
                                            VStack(spacing: 6) {
                                                ZStack {
                                                    Circle()
                                                        .fill(
                                                            LinearGradient(
                                                                colors: [themeCase.colors.accentPrimary,
                                                                         themeCase.colors.accentSecondary],
                                                                startPoint: .topLeading,
                                                                endPoint: .bottomTrailing
                                                            )
                                                        )
                                                        .frame(width: 44, height: 44)
                                                    if selectedTheme == themeCase {
                                                        Image(systemName: "checkmark")
                                                            .font(.system(size: 14, weight: .bold))
                                                            .foregroundStyle(.white)
                                                    }
                                                }
                                                Text(themeCase.displayName)
                                                    .font(.pCaption(11))
                                                    .foregroundStyle(
                                                        selectedTheme == themeCase
                                                        ? Color.pTextPrimary
                                                        : Color.pTextTertiary
                                                    )
                                            }
                                            .frame(maxWidth: .infinity)
                                        }
                                    }
                                }
                            }
                            .padding(18)
                        }

                        // 설정 목록
                        GlassCard {
                            VStack(spacing: 0) {
                                SettingsRow(icon: "bell", label: "알림 설정")
                                Divider().background(Color.pGlassBorder).padding(.horizontal, 16)
                                SettingsRow(icon: "lock", label: "개인정보 보호")
                                Divider().background(Color.pGlassBorder).padding(.horizontal, 16)
                                SettingsRow(icon: "questionmark.circle", label: "도움말")
                                Divider().background(Color.pGlassBorder).padding(.horizontal, 16)
                                SettingsRow(icon: "info.circle", label: "앱 정보 v1.0.0", showChevron: false)
                            }
                        }

                        // 위험 구역
                        VStack(alignment: .leading, spacing: 12) {
                            Text("계정 관리")
                                .font(.pCaption(12))
                                .foregroundStyle(Color.pTextTertiary)
                                .textCase(.uppercase)

                            GlassCard {
                                VStack(spacing: 12) {
                                    HStack {
                                        VStack(alignment: .leading, spacing: 2) {
                                            Text("회원 탈퇴")
                                                .font(.pBodyMedium(15))
                                                .foregroundStyle(Color.pDestructive)
                                            Text("모든 데이터가 영구 삭제됩니다")
                                                .font(.pCaption(12))
                                                .foregroundStyle(Color.pTextTertiary)
                                        }
                                        Spacer()
                                        DangerButton(title: "탈퇴하기", style: .outlined) {
                                            showWithdrawModal = true
                                        }
                                    }
                                }
                                .padding(18)
                            }
                        }

                        Spacer(minLength: 32)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                }
            }
            .navigationTitle("프로필")
            .navigationBarTitleDisplayMode(.large)
        }
        .toast(isPresented: $showSavedToast, message: "테마가 변경됐습니다", type: .success)
        .actionCheckModal(
            isPresented: $showWithdrawModal,
            title: "정말 탈퇴하시겠습니까?\n모든 기록이 삭제됩니다.",
            confirmLabel: "탈퇴하기",
            cancelLabel: "취소",
            onConfirm: { HapticManager.notification(.error) }
        )
    }
}

// MARK: - Profile Card

private struct ProfileCard: View {
    @Environment(\.pThemeColors) var theme

    var body: some View {
        GlassCard {
            HStack(spacing: 16) {
                // 아바타
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [theme.accentPrimary, theme.accentSecondary],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 64, height: 64)
                    Text("나")
                        .font(.pTitle(22))
                        .foregroundStyle(.white)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text("홍길동")
                        .font(.pTitle(17))
                        .foregroundStyle(Color.pTextPrimary)
                    Text("spring@palet.app")
                        .font(.pBody(13))
                        .foregroundStyle(Color.pTextSecondary)
                    HStack(spacing: 4) {
                        Image(systemName: "leaf.fill")
                            .font(.system(size: 10))
                            .foregroundStyle(theme.accentPrimary)
                        Text("봄 타입")
                            .font(.pCaption(12))
                            .foregroundStyle(theme.accentPrimary)
                    }
                }

                Spacer()

                CommonButton(title: "편집", style: .outlined, size: .small, action: {})
            }
            .padding(18)
        }
    }
}

// MARK: - Settings Row

private struct SettingsRow: View {
    let icon: String
    let label: String
    var showChevron: Bool = true

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 15))
                .foregroundStyle(Color.pTextSecondary)
                .frame(width: 24)
            Text(label)
                .font(.pBody(15))
                .foregroundStyle(Color.pTextPrimary)
            Spacer()
            if showChevron {
                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(Color.pTextTertiary)
            }
        }
        .padding(.horizontal, 16)
        .frame(height: 48)
    }
}
