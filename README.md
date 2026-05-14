# PersonalColorDesignSystem

개인 iOS 프로젝트 전용 디자인 시스템 Swift Package.

**UIKit + SwiftUI 동시 지원**

> 색상 토큰뿐 아니라 Typography, Gradient, GlassCard, Toast, Haptics 등 실제 쓸 수 있는 컴포넌트까지 포함.

**테마:** Dark mode fixed — Deep navy/purple 배경 + Lavender & Pink 액센트 + Glass morphism

---

## 설치

Xcode → File → Add Package Dependencies

```
https://github.com/KimNahun/PersonalColorDesignSystem
```

```swift
import PersonalColorDesignSystem
```

---

## 구조

```
Sources/PersonalColorDesignSystem/
├── Colors/
│   ├── ColorTokens.swift        — UIColor 토큰
│   └── Color+Tokens.swift       — SwiftUI Color 토큰
├── Typography/
│   ├── Typography.swift         — UIFont 토큰
│   └── Font+Tokens.swift        — SwiftUI Font 토큰
├── Gradients/
│   ├── GradientStyle.swift      — UIKit CAGradientLayer 헬퍼
│   └── GradientBackground.swift — SwiftUI 배경 modifier
└── Components/
    ├── GlassCard/
    │   ├── GlassCardView.swift  — UIKit UIView 서브클래스
    │   └── GlassCard.swift      — SwiftUI View + modifier
    ├── Toast/
    │   └── Toast.swift          — SwiftUI Toast 컴포넌트
    └── Haptics/
        └── HapticManager.swift  — Haptic 피드백 매니저
```

---

## Colors

모든 토큰은 `p` 접두사로 충돌 방지.

### SwiftUI
```swift
Text("Hello")
    .foregroundStyle(.pTextPrimary)

Rectangle()
    .fill(.pAccentPrimary)
```

### UIKit
```swift
label.textColor = .pTextPrimary
view.backgroundColor = .pAccentPrimary
```

| 토큰 | 설명 |
|------|------|
| `pAccentPrimary` | Soft lavender |
| `pAccentSecondary` | Soft pink |
| `pBackgroundTop/Mid/Bottom` | 배경 그라디언트 |
| `pGlassFill / pGlassBorder / pGlassSelected` | Glass morphism |
| `pTextPrimary / Secondary / Tertiary` | 텍스트 계층 |
| `pSuccess / pWarning / pDestructive` | 시멘틱 상태 |
| `pToastBackground` | Toast 배경 |
| `pTabBarBackground` | Tab bar 배경 |
| `pShadow` | 카드 그림자 |

---

## Typography

### SwiftUI
```swift
Text("12:30")
    .font(.pDisplay(64))

Text("알람")
    .font(.pTitle(20))

Text("매일 반복")
    .font(.pBody(14))
```

### UIKit
```swift
label.font = .pDisplay(64)
label.font = .pTitle(20)
label.font = .pBodyMedium(16)
label.font = .pBody(14)
label.font = .pCaption(12)
```

---

## Gradients

### SwiftUI
```swift
// 배경 전체에 그라디언트 적용
ContentView()
    .pGradientBackground()

// 배경 단독으로 사용
PGradientBackground()

// 액센트 그라디언트
PAccentGradient(direction: .horizontal)
    .frame(height: 2)
```

### UIKit
```swift
// viewDidLayoutSubviews에서 호출
view.applyBackgroundGradient()

// 레이어 직접 사용
let layer = UIColor.pBackgroundGradient(frame: view.bounds)
view.layer.insertSublayer(layer, at: 0)
```

---

## Components

### GlassCard (SwiftUI)
```swift
// Container 형태
GlassCard {
    VStack {
        Text("알람")
        Text("07:30")
    }
}

// Modifier 형태
VStack { ... }
    .glassCard(cornerRadius: 16)
```

### GlassCard (UIKit)
```swift
// UIView 서브클래스
let card = GlassCardView()
card.cornerRadius = 16

// Extension
anyView.applyGlassEffect(cornerRadius: 20)
```

---

### Toast (SwiftUI)

```swift
struct ContentView: View {
    @State private var showToast = false

    var body: some View {
        Button("저장") { showToast = true }
            .toast(isPresented: $showToast, message: "저장됐습니다", type: .success)
    }
}
```

| type | 아이콘 | 색상 |
|------|--------|------|
| `.success` | checkmark.circle.fill | pSuccess |
| `.warning` | exclamationmark.triangle.fill | pWarning |
| `.error` | xmark.circle.fill | pDestructive |
| `.info` | info.circle.fill | pAccentPrimary |

```swift
// 커스텀 아이콘
.toast(isPresented: $show, message: "알람 삭제됨", icon: "trash.fill", type: .error)

// 지속 시간 조정
.toast(isPresented: $show, message: "복사됨", type: .success, duration: 1.5)
```

---

### Haptics

```swift
// 단순 임팩트
HapticManager.impact()
HapticManager.impact(.heavy)

// 알림
HapticManager.notification(.success)
HapticManager.notification(.error)

// 선택
HapticManager.selection()

// SwiftUI modifier
Button("탭") { }
    .hapticOnTap(.light)
```

---

## 사용 중인 프로젝트

- [BetterAlarm](https://github.com/KimNahun/Better-Alarm)
