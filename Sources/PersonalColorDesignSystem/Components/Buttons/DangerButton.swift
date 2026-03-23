import SwiftUI

// MARK: - DangerButton

/// 삭제, 탈퇴 등 비가역적 액션 전용 버튼.
///
/// ```swift
/// DangerButton(title: "회원 탈퇴", style: .outlined, action: { })
/// DangerButton(title: "삭제", style: .filled, action: { })
/// ```
public struct DangerButton: View {

    public enum Style { case filled, outlined }

    let title: String
    let style: Style
    let action: () -> Void

    public init(
        title: String,
        style: Style = .outlined,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.style = style
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            Text(title)
                .font(.pBodyMedium(15))
                .foregroundStyle(style == .filled ? Color.white : Color.pDestructive)
                .padding(.horizontal, 16)
                .frame(height: 40)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(style == .filled ? Color.pDestructive : Color.clear)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(
                                    Color.pDestructive,
                                    lineWidth: style == .outlined ? 1 : 0
                                )
                        )
                )
        }
    }
}

// MARK: - Preview

#Preview("DangerButton") {
    ZStack {
        PGradientBackground()

        VStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 12) {
                Text("Outlined (기본)").font(.pCaption(12)).foregroundStyle(Color.pTextTertiary).textCase(.uppercase)
                DangerButton(title: "회원 탈퇴", style: .outlined, action: {})
            }

            VStack(alignment: .leading, spacing: 12) {
                Text("Filled").font(.pCaption(12)).foregroundStyle(Color.pTextTertiary).textCase(.uppercase)
                DangerButton(title: "정보 삭제", style: .filled, action: {})
            }
        }
        .padding()
    }
}
