import SwiftUI

// MARK: - PBottomSheetDetent

public enum PBottomSheetDetent {
    /// 콘텐츠 높이에 맞춤
    case fit
    /// 화면 높이의 비율 (0.0 ~ 1.0)
    case fraction(CGFloat)
    /// 고정 높이
    case fixed(CGFloat)
}

// MARK: - PBottomSheet (Modifier)

/// 드래그 가능한 바텀시트. detent(snap point) 설정 지원.
///
/// ```swift
/// ContentView()
///     .pBottomSheet(isPresented: $show) {
///         VStack { Text("내용") }
///     }
///
/// ContentView()
///     .pBottomSheet(isPresented: $show, detent: .fraction(0.5)) {
///         FilterSheet()
///     }
/// ```
private struct PBottomSheetModifier<SheetContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    let detent: PBottomSheetDetent
    let showHandle: Bool
    let sheetContent: SheetContent

    @State private var dragOffset: CGFloat = 0
    @State private var sheetHeight: CGFloat = 0

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
                    sheetBody
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
                .ignoresSafeArea(edges: .bottom)
            }
        }
        .animation(PAnimation.springSlow, value: isPresented)
    }

    private var sheetBody: some View {
        VStack(spacing: 0) {
            if showHandle {
                Capsule()
                    .fill(Color.pGlassBorder)
                    .frame(width: 36, height: 4)
                    .padding(.top, PSpacing.md)
                    .padding(.bottom, PSpacing.sm)
            }

            sheetContent
                .padding(.bottom, PSpacing.xl)
        }
        .frame(maxWidth: .infinity)
        .frame(height: sheetFrameHeight, alignment: .top)
        .background(
            RoundedRectangle(cornerRadius: PRadius.xl)
                .fill(Color(red: 0.1, green: 0.09, blue: 0.18))
                .overlay(
                    RoundedRectangle(cornerRadius: PRadius.xl)
                        .strokeBorder(Color.pGlassBorder, lineWidth: PBorder.hairline)
                )
                .ignoresSafeArea(edges: .bottom)
        )
        .pShadowHigh()
        .offset(y: max(dragOffset, 0))
        .gesture(
            DragGesture()
                .onChanged { dragOffset = $0.translation.height }
                .onEnded { value in
                    if value.translation.height > 100 {
                        withAnimation(PAnimation.springSlow) { isPresented = false }
                    } else {
                        withAnimation(PAnimation.spring) { dragOffset = 0 }
                    }
                    dragOffset = 0
                }
        )
    }

    private var sheetFrameHeight: CGFloat? {
        switch detent {
        case .fit: return nil
        case .fraction(let f):
            let screen = UIScreen.main.bounds.height
            return screen * min(max(f, 0.1), 0.95)
        case .fixed(let h):
            return h
        }
    }
}

public extension View {
    func pBottomSheet<Content: View>(
        isPresented: Binding<Bool>,
        detent: PBottomSheetDetent = .fit,
        showHandle: Bool = true,
        @ViewBuilder content: () -> Content
    ) -> some View {
        modifier(PBottomSheetModifier(
            isPresented: isPresented,
            detent: detent,
            showHandle: showHandle,
            sheetContent: content()
        ))
    }
}

// MARK: - Preview

#Preview("PBottomSheet") {
    PBottomSheetPreviewWrapper()
}

private struct PBottomSheetPreviewWrapper: View {
    @State private var showFit = false
    @State private var showHalf = false

    var body: some View {
        ZStack {
            PGradientBackground()
            VStack(spacing: PSpacing.md) {
                CommonButton(title: "Fit 시트", action: { showFit = true })
                CommonButton(title: "50% 시트", style: .outlined, action: { showHalf = true })
            }
        }
        .pBottomSheet(isPresented: $showFit) {
            VStack(alignment: .leading, spacing: PSpacing.xl) {
                PSectionHeader("옵션 선택")
                PListRow(icon: "square.and.arrow.up", title: "공유", showChevron: false, onTap: {})
                PDivider()
                PListRow(icon: "bookmark", title: "저장", showChevron: false, onTap: {})
                PDivider()
                PListRow(icon: "flag", title: "신고", showChevron: false, onTap: {})
            }
            .padding(.horizontal, PSpacing.xl)
            .padding(.top, PSpacing.sm)
        }
        .pBottomSheet(isPresented: $showHalf, detent: .fraction(0.5)) {
            VStack(alignment: .leading, spacing: PSpacing.xl) {
                PSectionHeader("필터")
                PSegmentedControl(options: ["전체", "최신", "인기"], selected: .constant(0))
                PDivider(label: "카테고리")
            }
            .padding(.horizontal, PSpacing.xl)
            .padding(.top, PSpacing.sm)
        }
    }
}
