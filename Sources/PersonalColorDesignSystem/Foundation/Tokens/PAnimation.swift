import SwiftUI

// MARK: - PAnimation

/// 표준 애니메이션 프리셋. 모든 컴포넌트 전환에 통일해 사용.
///
/// ```swift
/// .animation(PAnimation.spring, value: isExpanded)
/// withAnimation(PAnimation.easeOut) { isVisible = false }
/// ```
public enum PAnimation {
    /// 기본 스프링 — 대부분의 컴포넌트 전환에 사용 (response 0.3)
    public static let spring = Animation.spring(response: 0.3, dampingFraction: 0.8)
    /// 빠른 스프링 — 드롭다운, 칩 등 즉각 반응이 필요한 요소 (response 0.25)
    public static let springFast = Animation.spring(response: 0.25, dampingFraction: 0.8)
    /// 느린 스프링 — 바텀시트, 모달 등 무게감 있는 요소 (response 0.4)
    public static let springSlow = Animation.spring(response: 0.4, dampingFraction: 0.8)
    /// easeOut — 사라지는 전환 (dismiss, hide)
    public static let easeOut = Animation.easeOut(duration: 0.25)
    /// 빠른 easeOut — 토스트 dismiss
    public static let easeOutFast = Animation.easeOut(duration: 0.2)
    /// 느린 easeOut — 오버레이 dismiss
    public static let easeOutSlow = Animation.easeOut(duration: 0.35)
}

// MARK: - PDuration

/// 표준 애니메이션 지속 시간.
public enum PDuration {
    /// 0.2초 — 즉각적인 피드백
    public static let fast: TimeInterval = 0.2
    /// 0.3초 — 일반 전환
    public static let normal: TimeInterval = 0.3
    /// 0.5초 — 무게감 있는 전환
    public static let slow: TimeInterval = 0.5
    /// 2.5초 — Toast 자동 dismiss 기본값
    public static let toastDefault: TimeInterval = 2.5
}
