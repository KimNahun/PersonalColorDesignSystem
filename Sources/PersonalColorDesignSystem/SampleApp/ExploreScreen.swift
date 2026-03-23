import SwiftUI

// MARK: - Screen 4: Explore

#Preview("4. Explore") { ExploreScreen().pTheme(.winter) }

struct ExploreScreen: View {
    @Environment(\.pThemeColors) var theme
    @State private var searchText = ""
    @State private var selectedCategory: String? = nil
    @State private var selectedItem: StyleItem? = nil

    private let categories = ["전체", "일상", "직장", "특별한 날", "운동", "행사"]

    private var filteredItems: [StyleItem] {
        StyleItem.samples.filter { item in
            let matchesSearch = searchText.isEmpty || item.name.contains(searchText) || item.category.contains(searchText)
            let matchesCategory = selectedCategory == nil || selectedCategory == "전체" || item.category == selectedCategory
            return matchesSearch && matchesCategory
        }
    }

    var body: some View {
        NavigationView {
            ZStack {
                PGradientBackground()

                VStack(spacing: 16) {
                    // 검색 + 필터
                    VStack(spacing: 10) {
                        PTextField(
                            placeholder: "스타일 검색",
                            text: $searchText,
                            leadingIcon: "magnifyingglass",
                            trailingIcon: "xmark.circle.fill"
                        )

                        PDropdownButton(
                            placeholder: "카테고리 필터",
                            options: categories,
                            selectedOption: $selectedCategory
                        )
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 8)

                    // 결과
                    if filteredItems.isEmpty {
                        Spacer()
                        EmptyStateView(
                            icon: "magnifyingglass",
                            title: "검색 결과가 없습니다",
                            description: "다른 검색어나 카테고리로\n다시 시도해 보세요.",
                            actionTitle: "초기화",
                            action: {
                                searchText = ""
                                selectedCategory = nil
                            }
                        )
                        Spacer()
                    } else {
                        ScrollView(showsIndicators: false) {
                            LazyVGrid(columns: [
                                GridItem(.flexible(), spacing: 12),
                                GridItem(.flexible(), spacing: 12)
                            ], spacing: 12) {
                                ForEach(filteredItems) { item in
                                    ExploreCard(item: item)
                                        .onTapGesture {
                                            selectedItem = item
                                            HapticManager.impact(.light)
                                        }
                                }
                            }
                            .padding(.horizontal, 20)
                            .padding(.bottom, 32)
                        }
                    }
                }
            }
            .navigationTitle("탐색")
            .navigationBarTitleDisplayMode(.large)
            .sheet(item: $selectedItem) { item in
                DetailScreen(item: item)
            }
        }
    }
}

// MARK: - Explore Card

private struct ExploreCard: View {
    @Environment(\.pThemeColors) var theme
    let item: StyleItem

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // 이미지 영역
            ZStack {
                LinearGradient(
                    colors: [theme.accentPrimary.opacity(0.2), theme.accentSecondary.opacity(0.15)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                Image(systemName: item.icon)
                    .font(.system(size: 40, weight: .light))
                    .foregroundStyle(theme.accentPrimary)
            }
            .frame(height: 110)

            // 텍스트 영역
            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .font(.pBodyMedium(14))
                    .foregroundStyle(Color.pTextPrimary)
                HStack(spacing: 4) {
                    Image(systemName: "tag.fill")
                        .font(.system(size: 9))
                        .foregroundStyle(theme.accentPrimary)
                    Text(item.category)
                        .font(.pCaption(11))
                        .foregroundStyle(Color.pTextSecondary)
                }
            }
            .padding(12)
        }
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(theme.glassFill)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .strokeBorder(theme.glassBorder, lineWidth: 0.5)
                )
        )
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
