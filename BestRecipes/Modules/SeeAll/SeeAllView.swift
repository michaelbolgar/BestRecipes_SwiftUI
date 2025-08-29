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
    
    let type: SeeAllType
    @Binding var recipes: [RecipeModel]
    @Binding var isFavorited: Bool
    let toggleBookmark: (Int) -> Void

    // MARK: - Body
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack {
                ForEach(recipes) { recipe in
                    NavigationLink {
                        RecipeDetailView(recipeID: recipe.id)
                    } label: {
                        TrendingNowCell(
                            recipe: recipe,
                            isFavorited: $isFavorited,
                            toggleBookmark: { toggleBookmark(recipe.id)}
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

//#Preview("Trending now") {
//    NavigationStack {
//        SeeAllView(type: .trendingNow, items: RecipeBookable.trendingMockBookable)
//    }
//}


