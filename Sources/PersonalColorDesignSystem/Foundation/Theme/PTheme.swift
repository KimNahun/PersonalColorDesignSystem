import SwiftUI

// MARK: - PThemeColors

/// 테마별 색상 토큰 묶음.
public struct PThemeColors {

    // MARK: Theme-specific tokens
    public let accentPrimary: Color
    public let accentSecondary: Color
    public let backgroundTop: Color
    public let backgroundMid: Color
    public let backgroundBottom: Color

    // MARK: Fixed tokens (모든 테마 공통 — 어두운 배경 기준)
    public var glassFill: Color     { .white.opacity(0.08) }
    public var glassBorder: Color   { .white.opacity(0.15) }
    public var glassSelected: Color { .white.opacity(0.12) }

    public var textPrimary: Color   { .white }
    public var textSecondary: Color { .white.opacity(0.7) }
    public var textTertiary: Color  { .white.opacity(0.5) }

    public var success: Color     { Color(red: 0.5,  green: 0.9,  blue: 0.7) }
    public var warning: Color     { Color(red: 1.0,  green: 0.75, blue: 0.4) }
    public var destructive: Color { Color(red: 1.0,  green: 0.45, blue: 0.5) }

    public var shadow: Color          { .black.opacity(0.4) }
    public var toastBackground: Color { Color(white: 0.1).opacity(0.95) }
    public var tabBarBackground: Color{ Color(white: 0.08) }
}

// MARK: - PTheme

/// 퍼스널 컬러 시즌 기반 4가지 테마.
public enum PTheme: String, CaseIterable, Identifiable {
    case spring = "봄"
    case summer = "여름"
    case autumn = "가을"
    case winter = "겨울"

    public var id: String { rawValue }
    public var displayName: String { rawValue }

    public var icon: String {
        switch self {
        case .spring: return "leaf"
        case .summer: return "sun.max"
        case .autumn: return "wind"
        case .winter: return "snowflake"
        }
    }

    public var colors: PThemeColors {
        switch self {

        // 봄: 따뜻하고 생기있는 코럴 + 피치
        // 참고: Locket, Spring, BeReal 계열
        case .spring:
            return PThemeColors(
                accentPrimary:   Color(red: 1.00, green: 0.45, blue: 0.35),
                accentSecondary: Color(red: 1.00, green: 0.70, blue: 0.45),
                backgroundTop:   Color(red: 0.10, green: 0.07, blue: 0.06),
                backgroundMid:   Color(red: 0.18, green: 0.10, blue: 0.08),
                backgroundBottom:Color(red: 0.13, green: 0.09, blue: 0.07)
            )

        // 여름: 소프트 라벤더 + 핑크 (최초 디자인 시스템 원본 색상)
        // 참고: Spotify, Phantom, Zenly 계열
        case .summer:
            return PThemeColors(
                accentPrimary:   Color(red: 0.70, green: 0.50, blue: 1.00),
                accentSecondary: Color(red: 1.00, green: 0.60, blue: 0.70),
                backgroundTop:   Color(red: 0.08, green: 0.08, blue: 0.15),
                backgroundMid:   Color(red: 0.15, green: 0.10, blue: 0.25),
                backgroundBottom:Color(red: 0.10, green: 0.12, blue: 0.20)
            )

        // 가을: 황금빛 앰버 + 선명한 옐로우 — 노란색이 강하게 돋보이는 팔레트
        // hue ~45° 계열 — 풍성하고 따뜻한 골드/옐로우
        case .autumn:
            return PThemeColors(
                accentPrimary:   Color(red: 0.98, green: 0.72, blue: 0.08),
                accentSecondary: Color(red: 1.00, green: 0.90, blue: 0.25),
                backgroundTop:   Color(red: 0.10, green: 0.08, blue: 0.02),
                backgroundMid:   Color(red: 0.18, green: 0.13, blue: 0.03),
                backgroundBottom:Color(red: 0.14, green: 0.10, blue: 0.02)
            )

        // 겨울: 아이시 블루 + 민트 (여름 라벤더와 완전히 다른 색상)
        // hue ~195° 계열 — 차갑고 투명한 블루/틸
        case .winter:
            return PThemeColors(
                accentPrimary:   Color(red: 0.20, green: 0.72, blue: 1.00),
                accentSecondary: Color(red: 0.20, green: 0.92, blue: 0.80),
                backgroundTop:   Color(red: 0.03, green: 0.07, blue: 0.14),
                backgroundMid:   Color(red: 0.04, green: 0.11, blue: 0.22),
                backgroundBottom:Color(red: 0.03, green: 0.09, blue: 0.18)
            )
        }
    }
}

// MARK: - Environment

private struct PThemeColorsKey: EnvironmentKey {
    static let defaultValue: PThemeColors = PTheme.winter.colors
}

public extension EnvironmentValues {
    var pThemeColors: PThemeColors {
        get { self[PThemeColorsKey.self] }
        set { self[PThemeColorsKey.self] = newValue }
    }
}

public extension View {
    /// 이 뷰 및 하위 뷰 전체에 테마 적용.
    /// ```swift
    /// ContentView()
    ///     .pTheme(.spring)
    /// ```
    func pTheme(_ theme: PTheme) -> some View {
        environment(\.pThemeColors, theme.colors)
    }
}
