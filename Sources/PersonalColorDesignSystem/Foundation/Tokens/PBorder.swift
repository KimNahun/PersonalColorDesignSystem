import CoreGraphics
import SwiftUI

// MARK: - PBorder

/// 표준 border 두께 상수.
///
/// ```swift
/// .strokeBorder(Color.pGlassBorder, lineWidth: PBorder.hairline)
/// .border(theme.accentPrimary, width: PBorder.thin)
/// ```
public enum PBorder {
    /// 0.5pt — 글래스 컴포넌트 기본 테두리
    public static let hairline: CGFloat = 0.5
    /// 1.0pt — 일반 테두리
    public static let thin: CGFloat = 1.0
    /// 2.0pt — 강조 테두리 (포커스, 선택 상태)
    public static let thick: CGFloat = 2.0
}
