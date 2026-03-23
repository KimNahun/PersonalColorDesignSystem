import SwiftUI

// MARK: - Color Palette Preview

#Preview("Colors") {
    ScrollView {
        VStack(alignment: .leading, spacing: 24) {

            PreviewSectionHeader("Accent")
            HStack(spacing: 12) {
                ColorSwatch(color: .pAccentPrimary,   label: "pAccentPrimary\nsoft lavender")
                ColorSwatch(color: .pAccentSecondary, label: "pAccentSecondary\nsoft pink")
            }

            PreviewSectionHeader("Background")
            HStack(spacing: 12) {
                ColorSwatch(color: .pBackgroundTop,    label: "pBackgroundTop\ndeep navy")
                ColorSwatch(color: .pBackgroundMid,    label: "pBackgroundMid\ndark purple")
                ColorSwatch(color: .pBackgroundBottom, label: "pBackgroundBottom\ndeep blue-purple")
            }

            PreviewSectionHeader("Glass")
            HStack(spacing: 12) {
                ColorSwatch(color: .pGlassFill,     label: "pGlassFill\nwhite 8%",  dark: true)
                ColorSwatch(color: .pGlassBorder,   label: "pGlassBorder\nwhite 15%", dark: true)
                ColorSwatch(color: .pGlassSelected, label: "pGlassSelected\nwhite 12%", dark: true)
            }

            PreviewSectionHeader("Text")
            VStack(spacing: 8) {
                HStack(spacing: 12) {
                    ColorSwatch(color: .pTextPrimary,   label: "pTextPrimary",   dark: true)
                    ColorSwatch(color: .pTextSecondary, label: "pTextSecondary", dark: true)
                    ColorSwatch(color: .pTextTertiary,  label: "pTextTertiary",  dark: true)
                }
            }

            PreviewSectionHeader("Semantic")
            HStack(spacing: 12) {
                ColorSwatch(color: .pSuccess,     label: "pSuccess\nsoft green")
                ColorSwatch(color: .pWarning,     label: "pWarning\nwarm orange")
                ColorSwatch(color: .pDestructive, label: "pDestructive\nsoft red-pink")
            }

            PreviewSectionHeader("Misc")
            HStack(spacing: 12) {
                ColorSwatch(color: .pShadow,           label: "pShadow\nblack 40%",   dark: true)
                ColorSwatch(color: .pToastBackground,  label: "pToastBackground",     dark: true)
                ColorSwatch(color: .pTabBarBackground, label: "pTabBarBackground",    dark: true)
            }
        }
        .padding()
    }
    .background(Color(white: 0.15))
}

// MARK: - Typography Preview

#Preview("Typography") {
    ZStack {
        Color.pBackgroundTop.ignoresSafeArea()

        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                PreviewSectionHeader("Font Scale")
                    .foregroundStyle(Color.pTextSecondary)

                Group {
                    TypographySample(label: "pDisplay(34)", text: "Display", font: .pDisplay(34))
                    TypographySample(label: "pDisplay(28)", text: "Display", font: .pDisplay(28))
                    TypographySample(label: "pTitle(22)",   text: "Section Title", font: .pTitle(22))
                    TypographySample(label: "pTitle(17)",   text: "Section Title", font: .pTitle(17))
                    TypographySample(label: "pBodyMedium(16)", text: "Emphasized Body", font: .pBodyMedium(16))
                    TypographySample(label: "pBody(16)",    text: "Regular Body Text", font: .pBody(16))
                    TypographySample(label: "pBody(14)",    text: "Regular Body Text", font: .pBody(14))
                    TypographySample(label: "pCaption(12)", text: "Caption Label", font: .pCaption(12))
                }
            }
            .padding()
        }
    }
}

// MARK: - Gradient Preview

#Preview("Gradients") {
    ScrollView {
        VStack(spacing: 20) {
            PreviewSectionHeader("Background Gradient")
                .padding(.horizontal)

            ZStack {
                PGradientBackground()
                Text("PGradientBackground")
                    .font(.pTitle(17))
                    .foregroundStyle(Color.pTextPrimary)
            }
            .frame(height: 180)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .padding(.horizontal)

            PreviewSectionHeader("Accent Gradient — Horizontal")
                .padding(.horizontal)

            PAccentGradient(direction: .horizontal)
                .frame(height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal)

            PreviewSectionHeader("Accent Gradient — Vertical")
                .padding(.horizontal)

            PAccentGradient(direction: .vertical)
                .frame(height: 120)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal)

            PreviewSectionHeader("Accent Gradient — Text")
                .padding(.horizontal)

            PAccentGradient()
                .mask(
                    Text("Personal Color")
                        .font(.pDisplay(40))
                        .frame(maxWidth: .infinity)
                )
                .frame(height: 60)
                .padding(.horizontal)
        }
        .padding(.vertical)
    }
    .background(Color(white: 0.12))
}

// MARK: - Components Preview

#Preview("GlassCard") {
    ZStack {
        PGradientBackground()

        ScrollView {
            VStack(spacing: 24) {
                PreviewSectionHeader("Default (cornerRadius: 20)")
                    .foregroundStyle(Color.pTextSecondary)

                GlassCard {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Card Title")
                            .font(.pTitle(17))
                            .foregroundStyle(Color.pTextPrimary)
                        Text("보조 텍스트가 여기에 들어갑니다.")
                            .font(.pBody(14))
                            .foregroundStyle(Color.pTextSecondary)
                    }
                    .padding()
                }

                PreviewSectionHeader("Small (cornerRadius: 12)")
                    .foregroundStyle(Color.pTextSecondary)

                GlassCard(cornerRadius: 12) {
                    HStack(spacing: 12) {
                        Image(systemName: "star.fill")
                            .foregroundStyle(Color.pAccentPrimary)
                        Text("작은 카드")
                            .font(.pBodyMedium(15))
                            .foregroundStyle(Color.pTextPrimary)
                        Spacer()
                        Text("→")
                            .foregroundStyle(Color.pTextTertiary)
                    }
                    .padding()
                }

                PreviewSectionHeader("glassCard() Modifier")
                    .foregroundStyle(Color.pTextSecondary)

                Text("View Modifier 방식")
                    .font(.pBody(15))
                    .foregroundStyle(Color.pTextPrimary)
                    .padding()
                    .glassCard()
            }
            .padding()
        }
    }
}

#Preview("Toast") {
    ToastPreviewWrapper()
}

// MARK: - Preview Helpers

private struct ToastPreviewWrapper: View {
    @State private var showSuccess = false
    @State private var showWarning = false
    @State private var showError   = false
    @State private var showInfo    = false

    var body: some View {
        ZStack {
            PGradientBackground()

            VStack(spacing: 16) {
                PreviewSectionHeader("Toast Types")
                    .foregroundStyle(Color.pTextSecondary)

                Button("Success Toast") { showSuccess = true }
                    .buttonStyle(PreviewButtonStyle(color: .pSuccess))

                Button("Warning Toast") { showWarning = true }
                    .buttonStyle(PreviewButtonStyle(color: .pWarning))

                Button("Error Toast") { showError = true }
                    .buttonStyle(PreviewButtonStyle(color: .pDestructive))

                Button("Info Toast") { showInfo = true }
                    .buttonStyle(PreviewButtonStyle(color: .pAccentPrimary))
            }
            .padding()
        }
        .toast(isPresented: $showSuccess, message: "저장됐습니다!", type: .success)
        .toast(isPresented: $showWarning, message: "주의가 필요합니다", type: .warning)
        .toast(isPresented: $showError,   message: "오류가 발생했습니다", type: .error)
        .toast(isPresented: $showInfo,    message: "알림 메시지입니다", type: .info)
    }
}

// MARK: - Theme Switcher Preview

#Preview("Themes") {
    ThemeSwitcherPreview()
}

private struct ThemeSwitcherPreview: View {
    @State private var selectedTheme: PTheme = .winter
    @State private var selectedOption: String? = nil
    @State private var searchText = ""

    var body: some View {
        ZStack {
            PGradientBackground()

            VStack(spacing: 0) {
                // 테마 피커
                HStack(spacing: 8) {
                    ForEach(PTheme.allCases) { theme in
                        Button {
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                                selectedTheme = theme
                            }
                        } label: {
                            VStack(spacing: 4) {
                                Image(systemName: theme.icon)
                                    .font(.system(size: 18))
                                Text(theme.displayName)
                                    .font(.pCaption(11))
                            }
                            .foregroundStyle(selectedTheme == theme ? Color.white : Color.pTextTertiary)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(selectedTheme == theme ? Color.white.opacity(0.15) : Color.clear)
                            )
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 24)

                ScrollView {
                    VStack(spacing: 20) {
                        // 액센트 그라디언트
                        PAccentGradient()
                            .frame(height: 56)
                            .clipShape(RoundedRectangle(cornerRadius: 14))

                        // 텍스트 필드
                        PTextField(placeholder: "검색어 입력", text: $searchText, leadingIcon: "magnifyingglass", trailingIcon: "xmark.circle.fill")

                        // 드롭다운
                        PDropdownButton(placeholder: "카테고리 선택", options: ["전체", "음악", "스포츠", "기술"], selectedOption: $selectedOption)

                        // 버튼들
                        HStack(spacing: 10) {
                            CommonButton(title: "Filled", style: .filled, action: {})
                            CommonButton(title: "Outlined", style: .outlined, action: {})
                            CommonButton(title: "Ghost", style: .ghost, action: {})
                        }

                        // GlassCard
                        GlassCard {
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Card Title")
                                    .font(.pTitle(17)).foregroundStyle(Color.pTextPrimary)
                                Text("테마에 따라 액센트 색상이 바뀝니다.")
                                    .font(.pBody(14)).foregroundStyle(Color.pTextSecondary)
                            }
                            .padding()
                        }

                        // Bottom 버튼
                        BottomPlacedButton(title: "다음으로") {}
                        BottomPlacedButton(title: "취소", isSecondary: true) {}
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 32)
                }
            }
        }
        .pTheme(selectedTheme)
    }
}

// MARK: - All Components Overview

#Preview("All Components") {
    AllComponentsPreviewWrapper()
}

private struct AllComponentsPreviewWrapper: View {
    @State private var searchText = ""
    @State private var selectedOption: String? = nil
    @State private var showModal = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {

                // TextField
                PreviewSectionHeader("PTextField")
                PTextField(placeholder: "검색어 입력", text: $searchText,
                           leadingIcon: "magnifyingglass", trailingIcon: "xmark.circle.fill")

                // CommonButton
                PreviewSectionHeader("CommonButton")
                VStack(spacing: 10) {
                    HStack(spacing: 8) {
                        CommonButton(title: "Filled", style: .filled, action: {})
                        CommonButton(title: "Outlined", style: .outlined, action: {})
                        CommonButton(title: "Ghost", style: .ghost, action: {})
                    }
                    HStack(spacing: 8) {
                        CommonButton(title: "Small", style: .filled, size: .small, action: {})
                        CommonButton(title: "Small", style: .outlined, size: .small, action: {})
                    }
                }

                // DangerButton
                PreviewSectionHeader("DangerButton")
                HStack(spacing: 10) {
                    DangerButton(title: "회원 탈퇴", style: .outlined, action: {})
                    DangerButton(title: "삭제", style: .filled, action: {})
                }

                // Dropdown
                PreviewSectionHeader("PDropdownButton")
                PDropdownButton(
                    placeholder: "카테고리 선택",
                    options: ["전체", "음악", "스포츠", "기술"],
                    selectedOption: $selectedOption
                )

                // EmptyState
                PreviewSectionHeader("EmptyStateView")
                EmptyStateView(
                    icon: "magnifyingglass",
                    title: "검색 결과가 없습니다",
                    description: "다른 검색어로 시도해 보세요.",
                    actionTitle: "다시 검색",
                    action: {}
                )
                .background(RoundedRectangle(cornerRadius: 16).fill(Color.pGlassFill))

                // ActionCheckModal
                PreviewSectionHeader("ActionCheckModal")
                Button("모달 열기") { showModal = true }
                    .buttonStyle(PreviewButtonStyle(color: .pAccentPrimary))
            }
            .padding()
        }
        .background(Color(red: 0.08, green: 0.08, blue: 0.15))
        .actionCheckModal(isPresented: $showModal, title: "정말 삭제하시겠습니까?", onConfirm: {})
    }
}

// MARK: - Private Helpers

private struct ColorSwatch: View {
    let color: Color
    let label: String
    var dark: Bool = false

    var body: some View {
        VStack(spacing: 6) {
            RoundedRectangle(cornerRadius: 10)
                .fill(dark ? Color(white: 0.2) : Color(white: 0.9))
                .overlay(RoundedRectangle(cornerRadius: 10).fill(color))
                .frame(height: 60)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(Color.white.opacity(0.2), lineWidth: 0.5)
                )
            Text(label)
                .font(.system(size: 10))
                .foregroundStyle(Color(white: 0.8))
                .multilineTextAlignment(.center)
                .lineLimit(2)
        }
        .frame(maxWidth: .infinity)
    }
}

private struct TypographySample: View {
    let label: String
    let text: String
    let font: Font

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(label)
                .font(.system(size: 10))
                .foregroundStyle(Color.pTextTertiary)
            Text(text)
                .font(font)
                .foregroundStyle(Color.pTextPrimary)
            Divider().background(Color.pGlassBorder)
        }
    }
}

private struct PreviewSectionHeader: View {
    let title: String
    init(_ title: String) { self.title = title }

    var body: some View {
        Text(title)
            .font(.pCaption(12))
            .foregroundStyle(Color.pTextTertiary)
            .textCase(.uppercase)
    }
}

private struct PreviewButtonStyle: ButtonStyle {
    let color: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.pBodyMedium(15))
            .foregroundStyle(Color.pTextPrimary)
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
            .background(
                Capsule().fill(color.opacity(configuration.isPressed ? 0.5 : 0.25))
                    .overlay(Capsule().strokeBorder(color.opacity(0.5), lineWidth: 0.5))
            )
    }
}
