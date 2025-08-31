//
//  SeeAllView.swift
//  BestRecipes
//
//  Created by Sergey Zakurakin on 8/13/25.
//

import SwiftUI

struct SeeAllView: View {
    // MARK: - Properties
    @ObservedObject var homeViewModel: HomeViewModel
    @EnvironmentObject private var coreDataService: CoreDataService
    
    let type: SeeAllType
    
    // MARK: - Body
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack {
                ForEach(recipes()) { recipe in
                    NavigationLink {
                        RecipeDetailView(recipeID: recipe.id)
                    } label: {
                        SeeAllCell(
                            recipe: recipe,
                            isFavorited: coreDataService.favorites.isFavorite(recipeID: recipe.id),
                            toggleBookmark: { coreDataService.favorites.toggleFavorite(recipe)}
                        )
                        .padding(.vertical, Offsets.x2)
                    }
                }
            }
        }
        .background(Color.appBackground.ignoresSafeArea())
        .padding(.vertical, Offsets.x4)
        .padding(.horizontal, Offsets.x4)
        .navigationTitle(type.title)
        
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackBarButtonView()
            }
        }
    }
    // MARK: - Helper Methods
    
    private func recipes() -> [RecipeModel] {
        switch type {
        case .trendingNow:
            return homeViewModel.trendingNowRecipes
        case .popularCategories:
            return homeViewModel.popularCategoryRecipes
        case .cuisineByCountry:
            return homeViewModel.cuisineByCountries
        case .recentRecipe:
            let recentRecipes = homeViewModel.recentRecipes.map { RecipeModel(from: $0 )}
            return recentRecipes
            
        }
    }
    //    private func loadNextPage() async {
    //        switch type {
    //        case .trendingNow:
    //            await homeViewModel.loadTrendingNextPage()
    //        case .popularCategories:
    //            await homeViewModel.loadPopularNextPage()
    //        }
    //    }
    //
    //    private func refresh() async {
    //        switch type {
    //        case .trendingNow:
    //            await homeViewModel.refreshTrending()
    //        case .popularCategories:
    //            await homeViewModel.refreshPopular()
    //        }
    //    }
}

#Preview("Trending now") {
    NavigationStack {
        SeeAllView(
            homeViewModel: HomeViewModel(),
            type: .trendingNow
        )
        .environmentObject(CoreDataService.preview)
    }
}


