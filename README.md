# PersonalColorDesignSystem

개인 iOS 프로젝트 전용 디자인 시스템 Swift Package.

**테마:** Dark mode fixed — Deep navy/purple 배경 + Lavender & Pink 액센트 + Glass morphism

---

## 설치 (Swift Package Manager)

Xcode → File → Add Package Dependencies

```
https://github.com/KimNahun/PersonalColorDesignSystem
```

---

## 사용법

```swift
import PersonalColorDesignSystem
```

### Colors

```swift
view.backgroundColor = .pBackgroundTop
label.textColor = .pTextPrimary
label.textColor = .pTextSecondary
button.tintColor = .pAccentPrimary
```

| Token | 설명 |
|-------|------|
| `pAccentPrimary` | Soft lavender — 주요 액센트 |
| `pAccentSecondary` | Soft pink — 보조 액센트 |
| `pBackgroundTop/Mid/Bottom` | 배경 그라디언트 색상 |
| `pGlassFill` | Glass card 배경 (white 8%) |
| `pGlassBorder` | Glass card 테두리 (white 15%) |
| `pGlassSelected` | 선택된 glass 상태 (white 12%) |
| `pTextPrimary` | 기본 텍스트 — white |
| `pTextSecondary` | 보조 텍스트 — white 70% |
| `pTextTertiary` | 3차 텍스트 — white 50% |
| `pSuccess` | 성공/활성화 — soft green |
| `pWarning` | 경고/스킵 — warm orange |
| `pDestructive` | 위험/삭제 — soft red-pink |
| `pShadow` | 카드 그림자 — black 40% |

---

### Typography

```swift
label.font = .pDisplay(64)       // 큰 숫자/시간 표시
label.font = .pTitle(20)         // 섹션 타이틀
label.font = .pBodyMedium(16)    // 강조 본문
label.font = .pBody(14)          // 일반 본문
label.font = .pCaption(12)       // 캡션/레이블
```

---

### Gradient

```swift
// 배경 그라디언트 레이어
let gradientLayer = UIColor.pBackgroundGradient(frame: view.bounds)
view.layer.insertSublayer(gradientLayer, at: 0)

// 액센트 그라디언트 (lavender → pink)
let accentGradient = UIColor.pAccentGradient(frame: button.bounds, direction: .horizontal)
button.layer.insertSublayer(accentGradient, at: 0)
```

---

### Glass Morphism

```swift
// UIView에 glass card 스타일 적용
cardView.applyGlassStyle(cornerRadius: 16)

// UIViewController에서 배경 그라디언트 적용
override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    view.applyBackgroundGradient()
}
```

---

## 네이밍 컨벤션

모든 토큰은 `p` 접두사로 다른 프로젝트 토큰과 충돌 방지.

---

## 사용 중인 프로젝트

- [BetterAlarm](https://github.com/KimNahun/BetterAlarm)
