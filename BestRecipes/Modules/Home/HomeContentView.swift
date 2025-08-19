import SwiftUI

enum ContentMode: CaseIterable {
    case homeContent
    case searchContent
}

struct HomeContentView: View {
    // MARK: - Properties
    @StateObject private var viewModel: HomeViewModel
    @State private var navigationPath = NavigationPath()
    @State private var contentMode: ContentMode = .homeContent
    @State private var isHeaderHidden = false
    
    enum Route: Hashable {
        case recipeDetail(id: Int)
        case seeAll(type: SeeAllType, items: [RecipeModel])
        case seeAllCuisine(_ items: [Cuisine])
    }
    
    //    MARK: - INIT
    init() {
        self._viewModel = StateObject(wrappedValue: HomeViewModel())
    }
    
    // MARK: - Body
    var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack(alignment: .top) {
                Color(.appBackground)
                    .ignoresSafeArea(.all)
                VStack(spacing: Offsets.x0) {
                    hederView(searchText: $viewModel.searchText)
                    
                    switch contentMode {
                    case .homeContent:
                        homeContent
                    case .searchContent:
                        searchContent
                    }
                }
                .padding(.horizontal, Offsets.x4)
            }
            .task {
                await viewModel.fetchTrendingNowRecipes()
                await viewModel.fetchPopularCategoryRecipes()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .recipeDetail(let id):
                    RecipeDetailView(recipeID: id)
                case .seeAll(let type, let items):
                    SeeAllView(type: type, items: items)
                    
                case .seeAllCuisine(let items):
                    CuisineSeeAll(cuisine: items) { country in
                        Task {
                            await viewModel.fetchCuisineByCountries(country)
                            navigationPath.append(
                                Route.seeAll(
                                    type: .cuisineByCountry,
                                    items: viewModel.cuisineByCountries
                                )
                            )
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Views
    private func hederView(searchText: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: Offsets.x2) {
            if !isHeaderHidden {
                    Text(constText.hederText)
                        .recipesNavTitleStyle()
                        .lineLimit(2)
                        .transition(.opacity.combined(with: .move(edge: .top)))
                }
            
            SearchRecipeView(
                searchText: searchText,
                onTapSearch: {
                    withAnimation(.easeInOut) {
                        isHeaderHidden = true
                        contentMode = .searchContent
                    }
                },
                onTapCancel: {
                    withAnimation(.easeInOut) {
                        isHeaderHidden = false
                        contentMode = .homeContent
                    }
                }
            )
            .padding(.top, isHeaderHidden ? -Offsets.x2 : Offsets.x0)
        }
        .animation(.easeInOut, value: isHeaderHidden)
        .animation(.easeInOut, value: contentMode)
    }
    
    // MARK: - Home Content
    private var homeContent: some View {
        ScrollView(showsIndicators: false) {
            GeometryReader { proxy in
                Color.clear
                    .preference(
                        key: ScrollOffsetPreferenceKey.self,
                        value: proxy.frame(in:
                                .named(ScrollOffsetNamespace.homeNamespace))
                                .origin
                        )
            }
            .frame(height: 0)
            VStack(spacing: Offsets.x0) {
                trendingViewSection()
                    .padding(.top, Offsets.x4)
                popularViewSection()
                    .padding(.top, Offsets.x4)
                countryPopularViewSection()
                    .padding(.top, Offsets.x4)
                Spacer()
            }
            .padding(.top, Offsets.x4)
        }
        .coordinateSpace(name: ScrollOffsetNamespace.homeNamespace)
        .onPreferenceChange(ScrollOffsetPreferenceKey.self) { offset in
            withAnimation(.easeInOut) {
                isHeaderHidden = offset.y < -20
            }
        }
    }
    
    // MARK: - Search Content
    private var searchContent: some View {
        SearchContentView(
            viewModel: viewModel,
            onSelectRecipe: {  recipeID in
            navigationPath.append(Route.recipeDetail(id: recipeID))
        })
    }
    
    private func trendingViewSection() -> some View {
        Group {
            SeeAllSectionView(
                title: SeeAllType.trendingNow.title,
                isShowAll: !viewModel.trendingNowRecipes.isEmpty
            ){
                navigationPath.append(Route.seeAll(
                    type: .trendingNow,
                    items: viewModel.trendingNowRecipes)
                )
            }
            
            TrendingNowSection(
                recipe: viewModel.trendingNowRecipes,
                showDetail: { recipeID in
                    navigationPath.append(Route.recipeDetail(id: recipeID))
                })
            .padding(.top, Offsets.x2)
            .frame(width: 350)
        }
    }
    
    private func popularViewSection() -> some View {
        VStack(alignment: .leading) {
            SeeAllSectionView(
                title: SeeAllType.popularCategories.title,
                isShowAll: !viewModel.trendingNowRecipes.isEmpty
            ){
                navigationPath.append(Route.seeAll(
                    type: .popularCategories,
                    items: viewModel.popularCategoryRecipes)
                )
            }
            CategoryButtonCell(onCategorySelected: { category in
                viewModel.currentCategory = category})
            .padding(.top, Offsets.x1)
            
            PopularCategoriesSection(
                recipe: viewModel.popularCategoryRecipes,
                showDetail: { recipeID in
                    navigationPath.append(Route.recipeDetail(id: recipeID))
                }
            )
            .padding(.top, Offsets.x4)
        }
    }
    
    private func countryPopularViewSection() -> some View {
        VStack(alignment: .leading) {
            SeeAllSectionView(
                title: SeeAllType.cuisineByCountry.title,
                isShowAll: !viewModel.countries.isEmpty
            ){
                navigationPath.append(Route.seeAllCuisine(viewModel.countries)
                )
            }
            
            СuisineByCountriesSection(
                сuisine: viewModel.countries,
                showSeeAll: { country in
                    Task {
                        await viewModel.fetchCuisineByCountries(country)
                        navigationPath.append(Route.seeAll(
                            type: .cuisineByCountry,
                            items: viewModel.cuisineByCountries
                        ))
                    }
                }
            )
        }
    }
}
// MARK: - Extension
extension HomeContentView {
    enum constText {
        static let hederText: String = "Get amazing recipes for cooking"
    }
}

#Preview {
    HomeContentView()
}
