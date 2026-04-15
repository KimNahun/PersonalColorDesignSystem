import SwiftUI

// MARK: - PShadow

/// 표준 그림자 토큰. 레이어 고도에 따라 3단계.
///
/// ```swift
/// GlassCard { ... }
///     .pShadowLow()
///
/// PBottomSheet { ... }
///     .pShadowHigh()
/// ```
public extension View {
    /// 낮은 고도 그림자 — 카드, 칩
    func pShadowLow() -> some View {
        shadow(color: Color.pShadow.opacity(0.25), radius: 8, x: 0, y: 2)
    }

    /// 중간 고도 그림자 — 모달, 드롭다운
    func pShadowMid() -> some View {
        shadow(color: Color.pShadow.opacity(0.35), radius: 16, x: 0, y: 4)
    }

    /// 높은 고도 그림자 — 바텀시트, 오버레이
    func pShadowHigh() -> some View {
        shadow(color: Color.pShadow.opacity(0.5), radius: 24, x: 0, y: 8)
    }
}
