import SwiftUI

// MARK: - PBannerType

public enum PBannerType {
    case success, warning, error, info

    var icon: String {
        switch self {
        case .success: return "checkmark.circle.fill"
        case .warning: return "exclamationmark.triangle.fill"
        case .error:   return "xmark.circle.fill"
        case .info:    return "info.circle.fill"
        }
    }
}

// MARK: - PBanner

/// 인라인 상태 배너. Toast와 달리 화면 내 고정 위치에 표시.
/// dismiss 버튼으로 닫을 수 있음.
///
/// ```swift
/// PBanner(type: .error, message: "네트워크 연결을 확인해주세요")
///
/// PBanner(
///     type: .warning,
///     message: "저장되지 않은 변경사항이 있습니다",
///     isPresented: $showBanner
/// )
/// ```
public struct PBanner: View {
    @Environment(\.pThemeColors) private var theme
    let type: PBannerType
    let title: String?
    let message: String
    @Binding var isPresented: Bool
    let isDismissible: Bool

    public init(
        type: PBannerType,
        title: String? = nil,
        message: String,
        isPresented: Binding<Bool> = .constant(true),
        isDismissible: Bool = true
    ) {
        self.type = type
        self.title = title
        self.message = message
        self._isPresented = isPresented
        self.isDismissible = isDismissible
    }

    public var body: some View {
        if isPresented {
            HStack(alignment: .top, spacing: PSpacing.sm) {
                Image(systemName: type.icon)
                    .font(.system(size: 16))
                    .foregroundStyle(typeColor)

                VStack(alignment: .leading, spacing: PSpacing.xxs) {
                    if let title {
                        Text(title)
                            .font(.pBodyMedium(14))
                            .foregroundStyle(Color.pTextPrimary)
                    }
                    Text(message)
                        .font(.pBody(13))
                        .foregroundStyle(Color.pTextSecondary)
                        .fixedSize(horizontal: false, vertical: true)
                }

                Spacer(minLength: 0)

                if isDismissible {
                    Button {
                        withAnimation(PAnimation.easeOut) {
                            isPresented = false
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(Color.pTextTertiary)
                    }
                }
            }
            .padding(PSpacing.md)
            .background(
                RoundedRectangle(cornerRadius: PRadius.md)
                    .fill(typeColor.opacity(0.1))
                    .overlay(
                        RoundedRectangle(cornerRadius: PRadius.md)
                            .strokeBorder(typeColor.opacity(0.3), lineWidth: PBorder.hairline)
                    )
            )
            .transition(.move(edge: .top).combined(with: .opacity))
        }
    }

    private var typeColor: Color {
        switch type {
        case .success: return theme.success
        case .warning: return theme.warning
        case .error:   return theme.destructive
        case .info:    return theme.accentPrimary
        }
    }
}

// MARK: - Preview

#Preview("PBanner") {
    PBannerPreviewWrapper()
}

private struct PBannerPreviewWrapper: View {
    @State private var showWarning = true
    @State private var showError = true

    var body: some View {
        ZStack {
            PGradientBackground()
            ScrollView {
                VStack(spacing: PSpacing.md) {
                    PBanner(type: .success, message: "저장이 완료되었습니다.", isPresented: .constant(true))
                    PBanner(type: .info, title: "업데이트 안내", message: "새 버전이 출시되었습니다.", isPresented: .constant(true))
                    PBanner(type: .warning, message: "저장되지 않은 변경사항이 있습니다.", isPresented: $showWarning)
                    PBanner(type: .error, title: "오류", message: "네트워크 연결을 확인해주세요.", isPresented: $showError)
                }
                .padding(PSpacing.xl)
            }
        }
    }
}
