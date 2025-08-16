import SwiftUI

struct HomeContentView: View {
    // MARK: - Properties
    @StateObject private var viewModel: HomeViewModel
    
    @State private var navigationPath = NavigationPath()
    
    enum Route: Hashable {
        case recipeDetail(id: Int)
        case seeAll(type: SeeAllType, items: [RecipeModel])
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
                    
                    ScrollView(showsIndicators: false) {
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
                }
                .padding(.horizontal, Offsets.x4)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .recipeDetail(let id):
                    RecipeDetailView(
                        viewModel: RecipeDetailViewModel(),
                        isIngredientChecked: true
                    )
                case .seeAll(let type, let items):
                    SeeAllView(type: type, items: items)
                }
            }
        }
    }
    // MARK: - Views
    private func hederView(searchText: Binding<String>) -> some View {
        VStack(alignment: .leading) {
            Text(constText.hederText)
                .recipesNavTitleStyle()
                .lineLimit(2)
                .allowsTightening(true)
            SearchRecipeCell(searchText: searchText)
        }
    }
    
    private func trendingViewSection() -> some View {
        Group {
            SeeAllSectionView(
                title: SeeAllType.trendingNow.title,
                isShowAll: !viewModel.trendingNowRecipes.isEmpty
            )
            .onTapGesture {
                navigationPath.append(Route.seeAll(
                    type: .trendingNow,
                    items: viewModel.trendingNowRecipes
                )
                )
            }
            TrendingNowCell(
                recipe: viewModel.trendingNowRecipes,
                showDetail: { recipeID in
                    navigationPath.append(Route.recipeDetail(id: recipeID))
                })
            .padding(.top, Offsets.x2)
        }
    }
    
    private func popularViewSection() -> some View {
        VStack(alignment: .leading) {
            SeeAllSectionView(
                title: SeeAllType.popularCategories.title,
                isShowAll: !viewModel.trendingNowRecipes.isEmpty
            )
            .onTapGesture {
                navigationPath.append(Route.seeAll(
                    type: .popularCategories,
                    items: viewModel.popularCategoryRecipes
                )
                )
            }
            CategoryButtonCell(onCategorySelected: { category in
                viewModel.currentCategory = category})
                .padding(.top, Offsets.x1)
            
            PopularCategoriesCell(
                recipe: viewModel.popularCategoryRecipes,
                showDetail: { recipeID in
                    navigationPath.append(Route.recipeDetail(id: recipeID))
                }
            )
          
            .padding(.top, Offsets.x4)
        }
    }
    
    private func countryPopularViewSection() -> some View {
        Group {
            SeeAllSectionView(
                title: SeeAllType.cuisineByCountry.title,
                isShowAll: !viewModel.cuisineByCountries.isEmpty
            )
            .onTapGesture {
                navigationPath.append(Route.seeAll(
                    type: .cuisineByCountry,
                    items: viewModel.cuisineByCountries
                )
                )
            }
            
            СuisineByCountriesCell(
                recipe: viewModel.cuisineByCountries,
                showDetail: { recipeID in
                    navigationPath.append(Route.recipeDetail(id: recipeID))
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
