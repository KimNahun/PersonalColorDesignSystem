import SwiftUI

// MARK: - PActionSheetItem

public struct PActionSheetItem: Identifiable {
    public let id = UUID()
    public let title: String
    public let icon: String?
    public let role: ButtonRole?
    public let action: () -> Void

    public init(
        title: String,
        icon: String? = nil,
        role: ButtonRole? = nil,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.icon = icon
        self.role = role
        self.action = action
    }
}

// MARK: - PActionSheet

/// 하단에서 올라오는 액션 목록 시트. 글래스 스타일.
///
/// ```swift
/// ContentView()
///     .pActionSheet(
///         isPresented: $showSheet,
///         title: "사진 선택",
///         items: [
///             PActionSheetItem(title: "카메라", icon: "camera.fill") { openCamera() },
///             PActionSheetItem(title: "앨범", icon: "photo.fill") { openAlbum() },
///             PActionSheetItem(title: "삭제", icon: "trash.fill", role: .destructive) { delete() }
///         ]
///     )
/// ```
private struct PActionSheetView: View {
    @Environment(\.pThemeColors) private var theme
    let title: String?
    let items: [PActionSheetItem]
    let onDismiss: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            // Handle bar
            Capsule()
                .fill(Color.pGlassBorder)
                .frame(width: 36, height: 4)
                .padding(.top, PSpacing.md)
                .padding(.bottom, PSpacing.sm)

            if let title {
                Text(title)
                    .font(.pCaption(13))
                    .foregroundStyle(Color.pTextTertiary)
                    .padding(.bottom, PSpacing.sm)
            }

            // Items
            VStack(spacing: 0) {
                ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                    Button {
                        onDismiss()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                            item.action()
                        }
                    } label: {
                        HStack {
                            if let icon = item.icon {
                                Image(systemName: icon)
                                    .font(.system(size: 16))
                                    .frame(width: 24)
                                    .foregroundStyle(item.role == .destructive ? theme.destructive : theme.accentPrimary)
                            }
                            Text(item.title)
                                .font(.pBodyMedium(16))
                                .foregroundStyle(item.role == .destructive ? theme.destructive : Color.pTextPrimary)
                            Spacer()
                        }
                        .padding(.horizontal, PSpacing.xl)
                        .frame(height: 52)
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)

                    if index < items.count - 1 {
                        PDivider().padding(.horizontal, PSpacing.xl)
                    }
                }
            }
            .background(
                RoundedRectangle(cornerRadius: PRadius.xl)
                    .fill(Color.pToastBackground)
                    .overlay(
                        RoundedRectangle(cornerRadius: PRadius.xl)
                            .strokeBorder(Color.pGlassBorder, lineWidth: PBorder.hairline)
                    )
            )
            .padding(.horizontal, PSpacing.md)

            // 취소 버튼
            Button { onDismiss() } label: {
                Text("취소")
                    .font(.pBodyMedium(16))
                    .foregroundStyle(Color.pTextPrimary)
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
            }
            .background(
                RoundedRectangle(cornerRadius: PRadius.xl)
                    .fill(Color.pToastBackground)
                    .overlay(
                        RoundedRectangle(cornerRadius: PRadius.xl)
                            .strokeBorder(Color.pGlassBorder, lineWidth: PBorder.hairline)
                    )
            )
            .padding(.horizontal, PSpacing.md)
            .padding(.top, PSpacing.sm)
            .padding(.bottom, PSpacing.md)
        }
    }
}

// MARK: - Modifier

private struct PActionSheetModifier: ViewModifier {
    @Binding var isPresented: Bool
    let title: String?
    let items: [PActionSheetItem]

    func body(content: Content) -> some View {
        ZStack {
            content
            if isPresented {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(PAnimation.springSlow) { isPresented = false }
                    }
                    .transition(.opacity)

                VStack {
                    Spacer()
                    PActionSheetView(title: title, items: items) {
                        withAnimation(PAnimation.springSlow) { isPresented = false }
                    }
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
                .ignoresSafeArea(edges: .bottom)
            }
        }
        .animation(PAnimation.springSlow, value: isPresented)
    }
}

public extension View {
    func pActionSheet(
        isPresented: Binding<Bool>,
        title: String? = nil,
        items: [PActionSheetItem]
    ) -> some View {
        modifier(PActionSheetModifier(isPresented: isPresented, title: title, items: items))
    }
}

// MARK: - Preview

#Preview("PActionSheet") {
    PActionSheetPreviewWrapper()
}

private struct PActionSheetPreviewWrapper: View {
    @State private var show = false

    var body: some View {
        ZStack {
            PGradientBackground()
            BottomPlacedButton(title: "액션시트 열기") { show = true }
                .padding()
        }
        .pActionSheet(
            isPresented: $show,
            title: "사진 선택",
            items: [
                PActionSheetItem(title: "카메라로 촬영", icon: "camera.fill") {},
                PActionSheetItem(title: "앨범에서 선택", icon: "photo.fill") {},
                PActionSheetItem(title: "사진 삭제", icon: "trash.fill", role: .destructive) {},
            ]
        )
    }
}
