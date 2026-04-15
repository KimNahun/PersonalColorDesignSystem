# PersonalColorDesignSystem — 로드맵

> **기준일:** 2026-04-15
> **참조 디자인 시스템:** Apple HIG · Material Design 3 · Shopify Polaris · Carbon Design System (IBM) · Ant Design · Radix UI · Linear Design

---

## 현재 구현 현황

| 카테고리 | 구현된 항목 |
|---|---|
| **Foundation** | ColorTokens (UIKit+SwiftUI), Typography, Gradient, PTheme (봄/여름/가을/겨울) |
| **Button** | CommonButton (filled/outlined/ghost), DangerButton, BottomPlacedButton |
| **Input** | PTextField (leading/trailing icon) |
| **Overlay** | Toast (success/warning/error/info), ActionCheckModal |
| **Selection** | PDropdownButton |
| **Feedback** | EmptyStateView, HapticManager |
| **Layout** | GlassCard (UIKit+SwiftUI) |

---

## 추가 필요 컴포넌트 로드맵

우선순위: `🔴 High` — 범용·필수 / `🟡 Medium` — 자주 쓰임 / `🟢 Low` — 보완·고급

---

### 1. Foundation 토큰 확장

현재 Color·Typography는 완비됐으나, 나머지 디자인 원자가 없어 컴포넌트 구현 시 매직 넘버가 반복됨.

| 항목 | 설명 | 우선순위 | 레퍼런스 |
|---|---|---|---|
| **Spacing Tokens** | `PSpacing.xs(4)` ~ `PSpacing.xxl(64)` 표준 간격 상수 | 🔴 High | Material Design 3 · Carbon |
| **Corner Radius Tokens** | `PRadius.sm(8)` · `md(12)` · `lg(16)` · `xl(20)` · `full(999)` | 🔴 High | Polaris · Radix UI |
| **Shadow / Elevation Tokens** | `PShadow.low` · `mid` · `high` — 카드·모달·바텀시트 레이어별 | 🔴 High | Material Design 3 |
| **Animation Tokens** | `PAnimation.spring` · `easeOut` · `duration.fast/normal/slow` 공통 프리셋 | 🟡 Medium | Apple HIG · Linear |
| **Border Tokens** | `PBorder.hairline(0.5)` · `thin(1)` · `thick(2)` — glassBorder 중복 제거 | 🟡 Medium | Ant Design · Carbon |
| **Z-Index Tokens** | `PLayer.card / modal / toast / overlay` 계층 상수 | 🟡 Medium | Radix UI |
| **Opacity Tokens** | `POpacity.disabled(0.4)` · `secondary(0.7)` · `tertiary(0.5)` 공통 불투명도 | 🟢 Low | Material Design 3 |

---

### 2. Input / Form

사용자 입력 흐름 완결에 필수. 현재 PTextField 하나만 있는 상태.

| 항목 | 설명 | 우선순위 | 레퍼런스 |
|---|---|---|---|
| **PSecureField** | 비밀번호 입력 전용. eye/eye.slash 토글, 동일 글래스 스타일 | 🔴 High | Apple HIG · Polaris |
| **PToggle** | 시스템 Toggle 테마 오버라이드. accentPrimary 적용 | 🔴 High | Material Design 3 · Ant Design |
| **PCheckbox** | 체크박스. checked/unchecked/indeterminate 상태 | 🔴 High | Material Design 3 · Carbon |
| **PRadioButton** | 단일 선택 라디오. RadioGroup 컨테이너 포함 | 🟡 Medium | Material Design 3 · Radix UI |
| **PSlider** | 커스텀 슬라이더. 트랙·thumb 테마 적용, 값 레이블 옵션 | 🟡 Medium | Apple HIG · Material Design 3 |
| **PTextEditor** | 멀티라인 입력. 최소/최대 높이, 글자수 카운터 옵션 | 🟡 Medium | Polaris · Carbon |
| **POTPField** | 6자리 OTP 입력. 박스 분리형, 자동 포커스 이동 | 🟡 Medium | Ant Design |
| **PFormField** | label + input + error message 래퍼. 유효성 상태(normal/error/success) | 🔴 High | Polaris · Carbon · Ant Design |
| **PStepper** | +/- 버튼 수량 입력. min/max/step 설정 | 🟢 Low | Material Design 3 |

---

### 3. Selection / Display

데이터 태깅·필터링·선택에 광범위하게 사용됨.

| 항목 | 설명 | 우선순위 | 레퍼런스 |
|---|---|---|---|
| **PChip / PTag** | 선택 가능(toggle)·삭제 가능(removable)·레이블 전용 세 가지 variant | 🔴 High | Material Design 3 · Ant Design · Polaris |
| **PSegmentedControl** | iOS 네이티브 대체. 슬라이딩 indicator 애니메이션 | 🔴 High | Apple HIG · Linear |
| **PBadge** | 숫자·dot·상태 뱃지. 아이콘/아바타 위 overlay 형태 | 🔴 High | Ant Design · Material Design 3 |
| **PAvatar** | 이니셜·이미지 프로필. size 변형(sm/md/lg), 테마 배경색 | 🔴 High | Radix UI · Material Design 3 |
| **PAvatarGroup** | 최대 N개 표시 후 +n 오버플로우 | 🟡 Medium | Radix UI · Ant Design |
| **PRating** | 별점 입력·표시. 0.5단계 지원 옵션 | 🟢 Low | Material Design 3 · Ant Design |

---

### 4. Feedback / Status

로딩·진행·인라인 오류 등 UX 완결에 필수.

| 항목 | 설명 | 우선순위 | 레퍼런스 |
|---|---|---|---|
| **PSkeletonLoader** | Shimmer 애니메이션 플레이스홀더. 텍스트·카드·리스트 프리셋 | 🔴 High | Material Design 3 · Ant Design |
| **PProgressBar** | 선형 진행률 바. 결정/불확정 variant, accentPrimary 트랙 | 🔴 High | Material Design 3 · Carbon |
| **PProgressRing** | 원형 진행률. 카운트다운·업로드 진행 표현 | 🟡 Medium | Apple HIG · Material Design 3 |
| **PBanner** | 인라인 상태 배너. success/warning/error/info + dismiss 버튼 | 🔴 High | Polaris · Carbon · Material Design 3 |
| **PLoadingOverlay** | 전체화면 로딩 오버레이. 반투명 dim + ProgressView | 🔴 High | Apple HIG · Ant Design |
| **PErrorView** | 에러 상태 뷰. 아이콘·메시지·retry 버튼. EmptyStateView와 구분 | 🟡 Medium | Polaris · Carbon |

---

### 5. Layout / Structure

화면 구성의 기본 골격. 현재 GlassCard만 있음.

| 항목 | 설명 | 우선순위 | 레퍼런스 |
|---|---|---|---|
| **PDivider** | 수평/수직 구분선. hairline opacity 및 라벨 옵션 | 🔴 High | Apple HIG · Material Design 3 |
| **PSectionHeader** | 섹션 제목 + 선택적 우측 액션 버튼 | 🔴 High | Apple HIG |
| **PListRow** | 아이콘·제목·부제목·트레일링 콘텐츠 표준 리스트 행 | 🔴 High | Apple HIG · Polaris |
| **PStatCard** | 숫자 지표 카드. 값·단위·변화율(delta) 표시 | 🟡 Medium | Linear · Ant Design |
| **PInfoCard** | 아이콘+제목+설명 정보 카드. GlassCard 기반 | 🟡 Medium | Material Design 3 · Carbon |
| **PGrid** | 고정/가변 컬럼 그리드 레이아웃 래퍼 | 🟢 Low | Material Design 3 |

---

### 6. Navigation

탭·헤더·온보딩 흐름 지원. 현재 전혀 없는 상태.

| 항목 | 설명 | 우선순위 | 레퍼런스 |
|---|---|---|---|
| **PTabBar** | 커스텀 테마 탭바. selectedColor=accentPrimary, 글래스 배경 | 🔴 High | Apple HIG |
| **PNavigationBar** | 커스텀 네비게이션 헤더. 타이틀·back·trailing 액션 | 🔴 High | Apple HIG |
| **PPageIndicator** | 온보딩·캐러셀 페이지 닷 인디케이터. 현재 페이지 강조 | 🟡 Medium | Apple HIG |
| **PBreadcrumb** | 뎁스 탐색 경로 표시 (설정·계층 구조에 적합) | 🟢 Low | Carbon · Ant Design |

---

### 7. Overlay / Popup

iOS 인터랙션 패턴의 핵심. 현재 Modal 하나만 있음.

| 항목 | 설명 | 우선순위 | 레퍼런스 |
|---|---|---|---|
| **PBottomSheet** | 드래그 가능 바텀시트. detent(snap point) 설정, dim 배경 | 🔴 High | Apple HIG · Material Design 3 |
| **PTooltip** | 포인터형 말풍선 힌트. 방향(top/bottom/leading/trailing) 자동 감지 | 🟡 Medium | Radix UI · Ant Design |
| **PPopover** | 버튼 근처에 뜨는 인라인 콘텐츠 팝오버 | 🟡 Medium | Apple HIG · Radix UI |
| **PActionSheet** | 하단에서 올라오는 액션 목록 시트. 취소 버튼 포함 | 🔴 High | Apple HIG |
| **PContextMenu** | 길게 누르기 컨텍스트 메뉴. 글래스 스타일 메뉴 항목 | 🟢 Low | Apple HIG |

---

### 8. Imagery / Media

비주얼 콘텐츠 처리.

| 항목 | 설명 | 우선순위 | 레퍼런스 |
|---|---|---|---|
| **PAsyncImage** | 비동기 이미지 로딩 래퍼. skeleton → 이미지 전환 애니메이션 | 🟡 Medium | Polaris · Material Design 3 |
| **PImagePlaceholder** | 이미지 없을 때 아이콘+배경 플레이스홀더 | 🟡 Medium | Material Design 3 |

---

### 9. Utility / Modifier

공통으로 쓰이는 SwiftUI modifier 확장.

| 항목 | 설명 | 우선순위 | 레퍼런스 |
|---|---|---|---|
| **shimmer() modifier** | 어떤 뷰에도 적용 가능한 shimmer 애니메이션 | 🔴 High | — |
| **pressable() modifier** | 탭 시 scale-down 피드백 (.scaleEffect + haptic 통합) | 🔴 High | Apple HIG |
| **pBadge() modifier** | 뷰 위에 뱃지 overlay를 적용하는 modifier | 🟡 Medium | — |
| **conditionalModifier()** | `if`분기 없이 조건부 modifier 체이닝 | 🟡 Medium | — |
| **pCardShadow() modifier** | PShadow 토큰 기반 카드 그림자 통일 modifier | 🟡 Medium | — |

---

## 구현 순서 제안

```
Phase 1 — Foundation 완결 (Spacing · Radius · Shadow · Animation 토큰)
    ↓
Phase 2 — Form 완결 (PFormField · PToggle · PCheckbox · PSecureField)
    ↓
Phase 3 — 핵심 컴포넌트 (PChip · PBadge · PAvatar · PDivider · PListRow)
    ↓
Phase 4 — Overlay (PBottomSheet · PActionSheet · PBanner · PLoadingOverlay)
    ↓
Phase 5 — Navigation (PTabBar · PNavigationBar · PPageIndicator)
    ↓
Phase 6 — Feedback (PSkeletonLoader · PProgressBar · PProgressRing)
    ↓
Phase 7 — 보완 (PTooltip · PSegmentedControl · PStatCard · PRating 등)
```

---

## 설계 원칙 (추가 구현 시 공통 가이드)

1. **테마 필수 연동** — 모든 컴포넌트는 `@Environment(\.pThemeColors)` 로 accentPrimary/Secondary를 읽을 것.
2. **UIKit + SwiftUI 병행** — Foundation 레이어(토큰)는 양쪽 지원. 컴포넌트는 SwiftUI 우선, UIKit 래퍼는 수요가 생길 때.
3. **p 접두사 일관성** — 공개 타입명 `P`로 시작 (PChip, PBanner…). 내부 private 타입 제외.
4. **#Preview 필수** — 각 컴포넌트 파일에 `#Preview` 포함. variant·상태 별로 분리.
5. **접근성** — `accessibilityLabel` · `accessibilityHint` 기본 제공.
6. **애니메이션 통일** — Phase 1에서 만들 `PAnimation` 토큰만 사용, 매직 넘버 금지.
