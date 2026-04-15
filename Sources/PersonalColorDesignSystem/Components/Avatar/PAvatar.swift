import SwiftUI

// MARK: - PAvatarSize

public enum PAvatarSize {
    case sm, md, lg, xl

    var dimension: CGFloat {
        switch self {
        case .sm: return 24
        case .md: return 36
        case .lg: return 48
        case .xl: return 64
        }
    }

    var fontSize: CGFloat {
        switch self {
        case .sm: return 10
        case .md: return 14
        case .lg: return 18
        case .xl: return 24
        }
    }
}

// MARK: - PAvatarContent

public enum PAvatarContent {
    /// 이니셜 + 배경색 (자동 생성 가능)
    case initials(String, background: Color? = nil)
    /// SF Symbol 아이콘
    case icon(String)
    /// 이미지 URL (AsyncImage)
    case url(URL)
    /// SwiftUI Image
    case image(Image)
}

// MARK: - PAvatar

/// 프로필 아바타 컴포넌트.
///
/// ```swift
/// PAvatar(content: .initials("KN"), size: .lg)
/// PAvatar(content: .icon("person.fill"), size: .md)
/// PAvatar(content: .url(profileURL), size: .xl)
/// ```
public struct PAvatar: View {
    @Environment(\.pThemeColors) private var theme
    let content: PAvatarContent
    let size: PAvatarSize
    let showBorder: Bool

    public init(
        content: PAvatarContent,
        size: PAvatarSize = .md,
        showBorder: Bool = false
    ) {
        self.content = content
        self.size = size
        self.showBorder = showBorder
    }

    public var body: some View {
        ZStack {
            Circle()
                .fill(backgroundColor)

            contentView
                .clipShape(Circle())
        }
        .frame(width: size.dimension, height: size.dimension)
        .overlay(
            Circle()
                .strokeBorder(
                    showBorder ? theme.accentPrimary : Color.pGlassBorder,
                    lineWidth: showBorder ? PBorder.thick : PBorder.hairline
                )
        )
    }

    @ViewBuilder
    private var contentView: some View {
        switch content {
        case .initials(let text, _):
            Text(initialsFrom(text))
                .font(.system(size: size.fontSize, weight: .semibold))
                .foregroundStyle(.white)

        case .icon(let name):
            Image(systemName: name)
                .font(.system(size: size.fontSize, weight: .medium))
                .foregroundStyle(.white)

        case .url(let url):
            AsyncImage(url: url) { phase in
                switch phase {
                case .success(let image):
                    image.resizable().scaledToFill()
                default:
                    Image(systemName: "person.fill")
                        .font(.system(size: size.fontSize))
                        .foregroundStyle(.white)
                }
            }

        case .image(let image):
            image.resizable().scaledToFill()
        }
    }

    private var backgroundColor: Color {
        switch content {
        case .initials(_, let bg): return bg ?? theme.accentPrimary.opacity(0.6)
        case .icon: return Color.pGlassFill
        case .url, .image: return Color.pGlassFill
        }
    }

    private func initialsFrom(_ name: String) -> String {
        let words = name.split(separator: " ")
        if words.count >= 2 {
            return String(words[0].prefix(1) + words[1].prefix(1)).uppercased()
        }
        return String(name.prefix(2)).uppercased()
    }
}

// MARK: - PAvatarGroup

/// 아바타 그룹. 최대 N개 표시 후 +n 오버플로우.
///
/// ```swift
/// PAvatarGroup(contents: [.initials("A"), .initials("B"), .initials("C")], max: 4)
/// ```
public struct PAvatarGroup: View {
    @Environment(\.pThemeColors) private var theme
    let contents: [PAvatarContent]
    let max: Int
    let size: PAvatarSize

    public init(contents: [PAvatarContent], max: Int = 4, size: PAvatarSize = .md) {
        self.contents = contents
        self.max = max
        self.size = size
    }

    private var visible: [PAvatarContent] { Array(contents.prefix(max)) }
    private var overflow: Int { max(0, contents.count - max) }
    private var overlap: CGFloat { size.dimension * 0.35 }

    public var body: some View {
        HStack(spacing: -overlap) {
            ForEach(Array(visible.enumerated()), id: \.offset) { _, content in
                PAvatar(content: content, size: size, showBorder: true)
            }
            if overflow > 0 {
                ZStack {
                    Circle()
                        .fill(Color.pGlassFill)
                        .frame(width: size.dimension, height: size.dimension)
                        .overlay(Circle().strokeBorder(theme.accentPrimary, lineWidth: PBorder.thick))
                    Text("+\(overflow)")
                        .font(.system(size: size.fontSize - 1, weight: .semibold))
                        .foregroundStyle(theme.accentPrimary)
                }
            }
        }
    }
}

// MARK: - Preview

#Preview("PAvatar") {
    ZStack {
        PGradientBackground()
        VStack(spacing: PSpacing.xxl) {
            HStack(spacing: PSpacing.lg) {
                PAvatar(content: .initials("김나훈"), size: .sm)
                PAvatar(content: .initials("AB"), size: .md)
                PAvatar(content: .initials("CD"), size: .lg)
                PAvatar(content: .initials("EF"), size: .xl)
            }

            HStack(spacing: PSpacing.lg) {
                PAvatar(content: .icon("person.fill"), size: .sm)
                PAvatar(content: .icon("star.fill"), size: .md)
                PAvatar(content: .icon("heart.fill"), size: .lg)
                PAvatar(content: .icon("bell.fill"), size: .xl)
            }

            PAvatarGroup(
                contents: [
                    .initials("KN"),
                    .initials("AB"),
                    .initials("CD"),
                    .initials("EF"),
                    .initials("GH"),
                    .initials("IJ"),
                ],
                max: 4,
                size: .md
            )
        }
    }
}
