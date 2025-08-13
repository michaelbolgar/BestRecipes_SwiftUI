import SwiftUI

struct HomeContentView: View {
    // MARK: - Properties
    @StateObject private var viewModel: HomeViewModel
    @State private var selectedRecipeID: Int? = nil
    
    //    MARK: - INIT
    init() {
        self._viewModel = StateObject(wrappedValue: HomeViewModel())
    }
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .top) {
            Color(AppColor.backgroundColor)
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
                title: SeeAllExploreType.trendingNow.title,
                isShowAll: viewModel.trendingNowRecipes.isEmpty == false
            )
            
            TrendingNowCell(
                recipe: viewModel.trendingNowRecipes,
                showDetail: { recipeID in
                    selectedRecipeID = recipeID
                })
            .padding(.top, Offsets.x3)
        }
    }
    
    private func popularViewSection() -> some View {
        Group {
            SeeAllSectionView(
                title: SeeAllExploreType.popularCategories.title,
                isShowAll: viewModel.trendingNowRecipes.isEmpty == false
            )
            
            CategoryButtonCell(onCategorySelected: {_ in })
                .padding(.top, Offsets.x1)
            
            PopularCategoryCell(
                recipe: viewModel.popularCategoryRecipes,
                showDetail: { recipeID in
                    selectedRecipeID = recipeID
                    
                }
            )
        }
    }
    
    private func countryPopularViewSection() -> some View {
        Group {
            SeeAllSectionView(
                title: SeeAllExploreType.cuisineByCountry.title,
                isShowAll: viewModel.cuisineByCountrys.isEmpty == false
            )
            
            CountryRecipeCell(
                recipe: viewModel.popularCategoryRecipes,
                showDetail: { recipeID in
                    selectedRecipeID = recipeID
                    
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
