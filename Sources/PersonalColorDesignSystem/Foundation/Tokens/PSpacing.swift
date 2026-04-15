import CoreGraphics

// MARK: - PSpacing

/// 표준 간격 상수. padding/spacing 값을 매직 넘버 없이 통일.
///
/// ```swift
/// .padding(PSpacing.lg)
/// VStack(spacing: PSpacing.sm) { }
/// ```
public enum PSpacing {
    /// 2pt — 최소 간격
    public static let xxs: CGFloat = 2
    /// 4pt — 아이콘 내부 간격
    public static let xs: CGFloat = 4
    /// 8pt — 컴포넌트 내부 간격
    public static let sm: CGFloat = 8
    /// 12pt — 작은 섹션 간격
    public static let md: CGFloat = 12
    /// 16pt — 기본 padding
    public static let lg: CGFloat = 16
    /// 20pt — 화면 수평 padding
    public static let xl: CGFloat = 20
    /// 24pt — 카드 내부 padding
    public static let xxl: CGFloat = 24
    /// 32pt — 섹션 간 간격
    public static let xxxl: CGFloat = 32
    /// 48pt — 대형 섹션 간격
    public static let huge: CGFloat = 48
    /// 64pt — 최대 간격
    public static let giant: CGFloat = 64
}
