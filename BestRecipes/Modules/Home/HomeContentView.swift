import SwiftUI

enum ContentMode: CaseIterable {
    case homeContent
    case searchContent
}

struct HomeContentView: View {
    // MARK: - Properties
    @StateObject private var viewModel: HomeViewModel
    @EnvironmentObject private var coreDataService: CoreDataService
    
    @State private var navigationPath = NavigationPath()
    @State private var contentMode: ContentMode = .homeContent
    @State private var isHeaderHidden = false
    
    enum Route: Hashable {
        case seeAll(type: SeeAllType)
        case recipeDetail(id: Int)
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
                VStack(spacing: Offsets.x2) {
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
            .onReceive(coreDataService.$recentRecipes, perform: { entities in
                let recentRecepesItems: [RecentRecipesModel] = entities.map { RecentRecipesModel(with: $0)}
                viewModel.fetchRecentRecipe(recentRecepesItems)
            })
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .seeAll(let type):
                    SeeAllView(type: type, items: bindingForType(type)) { id in
                        viewModel.toggleFavorite(for: id, type: type)
                    }

                case .recipeDetail(let id):
                    RecipeDetailView(recipeID: id)

                    
                case .seeAllCuisine(let items):
                    CuisineSeeAll(cuisine: items) { country in
                        Task {
                            await viewModel.fetchCuisineByCountries(country)
                            navigationPath.append(
                                Route.seeAll(
                                    type: .cuisineByCountry
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
            
            SearchBarView(
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
                    .padding(.top, -Offsets.x2)
                popularViewSection()
                    .padding(.top, Offsets.x4)
                if !viewModel.recentRecipes.isEmpty {
                    recentViewSection()
                        .padding(.top, Offsets.x4)
                }
                countryPopularViewSection()
                    .padding(.top, Offsets.x2)
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
            onSelectRecipe: { recipeID in
            navigationPath.append(Route.recipeDetail(id: recipeID))
        })
        .onAppear {
            viewModel.loadRecentSearches()
        }
    }
    
    private func trendingViewSection() -> some View {
        VStack(alignment: .leading, spacing: .zero) {
            SeeAllSectionView(
                title: SeeAllType.trendingNow.title,
                isShowAll: !viewModel.trendingNowRecipes.isEmpty
            ){
                navigationPath.append(Route.seeAll(
                    type: .trendingNow)
                )
            }
            
            TrendingNowSection(
                recipe: viewModel.trendingNowRecipes,
                showDetail: { recipeID in
                    if let recipe = viewModel.trendingNowRecipesFavoritable.first(where: { $0.id == recipeID }) {
//                        viewModel.addRecentRecipe(<#T##RecentRecipesModel#>)
                    }
                    navigationPath.append(Route.recipeDetail(id: recipeID))
                },
                toggleBookmark: { recipeID in
                    viewModel.toggleFavorite(for: recipeID, type: .trendingNow)
                }
            )
            .padding(.top, Offsets.x0)
        }
    }
    
    private func popularViewSection() -> some View {
        VStack(alignment: .leading) {
            SeeAllSectionView(
                title: SeeAllType.popularCategories.title,
                isShowAll: !viewModel.popularCategoryRecipes.isEmpty
            ){
                navigationPath.append(Route.seeAll(
                    type: .popularCategories)
                )
            }
            CategoryButtonCell(onCategorySelected: { category in
                viewModel.currentCategory = category})
            .padding(.top, -Offsets.x2)

            PopularCategoriesSection(
                recipe: viewModel.popularCategoryRecipes,
                showDetail: { recipeID in
                    navigationPath.append(Route.recipeDetail(id: recipeID))
                }, toggleBookmark: { recipeID in
                    viewModel.toggleFavorite(for: recipeID, type: .popularCategories)
                }
            )
            .padding(.top, Offsets.x4)
        }
    }
    
    private func recentViewSection() -> some View {
        VStack(alignment: .leading) {
            SeeAllSectionView(
                title: SeeAllType.recentRecipe.title,
                isShowAll: !viewModel.recentRecipes.isEmpty
            ){
                let items = viewModel.recentRecipes.map { RecipeModel(from: $0)}
                navigationPath.append(Route.seeAll(
                    type: .recentRecipe)
                )
            }

            RecentSectionView(
                recipe: viewModel.recentRecipes,
                showDetail: { recipeID in
                    navigationPath.append(Route.recipeDetail(id: recipeID))
                }
            )
            .padding(.top, -Offsets.x2)
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
                            type: .cuisineByCountry
                        ))
                    }
                }
            )
            .padding(.top, -Offsets.x2)
        }
    }
}
// MARK: - Extension
extension HomeContentView {
    enum constText {
        static let hederText: String = "Get amazing recipes for cooking"
    }
}

extension HomeContentView {
    private func bindingForType(_ type: SeeAllType) -> Binding<[RecipeModel]> {
        switch type {
        case .trendingNow:
            return $viewModel.trendingNowRecipes
        case .popularCategories:
            return $viewModel.popularCategoryRecipes
        case .cuisineByCountry:
            return $viewModel.cuisineByCountries
        case .recentRecipe:
            return $viewModel.popularCategoryRecipes //mock
        }
    }
}

#Preview {
    HomeContentView()
        .environmentObject(CoreDataService())
}
