import CoreGraphics

// MARK: - PRadius

/// 표준 corner radius 상수.
///
/// ```swift
/// RoundedRectangle(cornerRadius: PRadius.lg)
/// .clipShape(RoundedRectangle(cornerRadius: PRadius.full))
/// ```
public enum PRadius {
    /// 4pt — 태그, 배지 등 소형 요소
    public static let xs: CGFloat = 4
    /// 8pt — 작은 버튼, 칩
    public static let sm: CGFloat = 8
    /// 12pt — 텍스트필드, 드롭다운
    public static let md: CGFloat = 12
    /// 16pt — 카드
    public static let lg: CGFloat = 16
    /// 20pt — 모달, 바텀시트
    public static let xl: CGFloat = 20
    /// 24pt — 대형 카드
    public static let xxl: CGFloat = 24
    /// 999pt — 완전한 원형 (알약 형태)
    public static let full: CGFloat = 999
}
