//
//  SeeAllView.swift
//  BestRecipes
//
//  Created by Sergey Zakurakin on 8/13/25.
//

import SwiftUI

struct SeeAllView: View {
    @ObservedObject var homeViewModel: HomeViewModel
    
    let type: SeeAllType
    @Binding var items: [RecipeFavoritable]
    let toggleBookmark: (Int) -> Void

    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack {
                ForEach(items) { item in
                    NavigationLink {
                        RecipeDetailView(recipeID: item.id)
                    } label: {
                        RecipeListRow(recipe: item, toggleBookmark: { toggleBookmark(item.id) })
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
    
    private func loadNextPage() async {
        switch type {
        case .trendingNow:
            await homeViewModel.loadTrendingNextPage()
        case .popularCategories:
            await homeViewModel.loadPopularNextPage()
        }
    }

    private func refresh() async {
        switch type {
        case .trendingNow:
            await homeViewModel.refreshTrending()
        case .popularCategories:
            await homeViewModel.refreshPopular()
        }
    }
}

//#Preview("Trending now") {
//    NavigationStack {
//        SeeAllView(type: .trendingNow, items: RecipeBookable.trendingMockBookable)
//    }
//}


