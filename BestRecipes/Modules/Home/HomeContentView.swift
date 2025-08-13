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
            
            VStack(spacing: 0) {
                
                hederView(searchText: $viewModel.searchText)
                trendingViewSection()
                
                CategoryButtonCell(onCategorySelected: {_ in })
                    .padding(.top, Offsets.x4)
                Spacer()
            }
            .padding(.top, Offsets.x4)
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
        }
    }
    
    
}

extension HomeContentView {
    enum constText {
        static let hederText: String = "Get amazing recipes for cooking"
    }
}

#Preview {
    HomeContentView()
     
}
