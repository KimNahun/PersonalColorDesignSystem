import SwiftUI

// MARK: - Screen 5: Detail

#Preview("5. Detail") {
    DetailScreen(item: StyleItem.samples[0])
        .pTheme(.winter)
}

struct DetailScreen: View {
    @Environment(\.pThemeColors) var theme
    @Environment(\.dismiss) var dismiss
    let item: StyleItem

    @State private var isSaved = false
    @State private var showSavedToast = false
    @State private var showShareToast = false
    @State private var showDeleteModal = false

    var body: some View {
        ZStack {
            PGradientBackground()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {

                    // 히어로 이미지
                    ZStack {
                        PAccentGradient()
                            .opacity(0.25)
                        Image(systemName: item.icon)
                            .font(.system(size: 80, weight: .ultraLight))
                            .foregroundStyle(theme.accentPrimary)
                    }
                    .frame(height: 220)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .overlay(
                        RoundedRectangle(cornerRadius: 24)
                            .strokeBorder(theme.glassBorder, lineWidth: 0.5)
                    )

                    // 제목 + 태그
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(item.name)
                                    .font(.pDisplay(28))
                                    .foregroundStyle(Color.pTextPrimary)
                                Text(item.category)
                                    .font(.pBody(14))
                                    .foregroundStyle(theme.accentPrimary)
                            }
                            Spacer()
                            Button {
                                isSaved.toggle()
                                HapticManager.notification(isSaved ? .success : .warning)
                                showSavedToast = true
                            } label: {
                                Image(systemName: isSaved ? "bookmark.fill" : "bookmark")
                                    .font(.system(size: 22))
                                    .foregroundStyle(isSaved ? theme.accentPrimary : Color.pTextTertiary)
                            }
                        }
                    }

                    // 설명 카드
                    GlassCard {
                        VStack(alignment: .leading, spacing: 12) {
                            Label("스타일 설명", systemImage: "text.alignleft")
                                .font(.pCaption(12))
                                .foregroundStyle(Color.pTextTertiary)
                                .textCase(.uppercase)

                            Text(item.description)
                                .font(.pBody(15))
                                .foregroundStyle(Color.pTextSecondary)
                                .lineSpacing(4)
                        }
                        .padding(18)
                    }

                    // 추천 컬러 팔레트
                    GlassCard {
                        VStack(alignment: .leading, spacing: 12) {
                            Label("추천 컬러", systemImage: "paintpalette")
                                .font(.pCaption(12))
                                .foregroundStyle(Color.pTextTertiary)
                                .textCase(.uppercase)

                            HStack(spacing: 10) {
                                ForEach(0..<5, id: \.self) { i in
                                    Circle()
                                        .fill(
                                            LinearGradient(
                                                colors: [
                                                    theme.accentPrimary.opacity(1.0 - Double(i) * 0.15),
                                                    theme.accentSecondary.opacity(1.0 - Double(i) * 0.1)
                                                ],
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                        )
                                        .frame(width: 44, height: 44)
                                        .overlay(
                                            Circle().strokeBorder(Color.white.opacity(0.2), lineWidth: 0.5)
                                        )
                                }
                                Spacer()
                            }
                        }
                        .padding(18)
                    }

                    // 액션 버튼들
                    HStack(spacing: 10) {
                        CommonButton(title: "공유", style: .outlined, action: {
                            HapticManager.impact(.medium)
                            showShareToast = true
                        })
                        CommonButton(title: "삭제", style: .ghost, action: {
                            showDeleteModal = true
                        })
                    }

                    Spacer(minLength: 100)
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
            }
        }
        .bottomButtons {
            BottomPlacedButton(title: isSaved ? "저장됨 ✓" : "내 컬렉션에 저장") {
                isSaved = true
                HapticManager.notification(.success)
                showSavedToast = true
            }
        }
        .toast(isPresented: $showSavedToast,
               message: isSaved ? "컬렉션에 저장됐습니다" : "저장을 취소했습니다",
               type: isSaved ? .success : .info)
        .toast(isPresented: $showShareToast, message: "링크가 복사됐습니다", type: .info, icon: "link")
        .actionCheckModal(
            isPresented: $showDeleteModal,
            title: "이 스타일을 삭제하시겠습니까?",
            confirmLabel: "삭제",
            cancelLabel: "취소",
            onConfirm: {
                HapticManager.notification(.error)
                dismiss()
            }
        )
    }
}

private extension View {
    func toast(isPresented: Binding<Bool>, message: String, type: ToastType, icon: String) -> some View {
        self.toast(isPresented: isPresented, message: message, icon: icon, type: type)
    }
}
