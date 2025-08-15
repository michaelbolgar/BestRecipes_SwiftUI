//
//  RecipeDetailView.swift
//  BestRecipes
//
//  Created by KOZLOVA Anastasia on 14.08.2025.
//


final class RecipeDetailView: ObservableObject {
    @Published var items: [RecipeModel] = []
    let type: SeeAllExploreType

    init(type: SeeAllExploreType) {
        self.type = type
        loadItems()
    }

    private func loadItems() {
        switch type {
        case .trendingNow:
            items = RecipeModel.trendingMock
        case .popularCategories:
            items = RecipeModel.popularCategoryMock
        case .cuisineByCountry:
            items = RecipeModel.cuisineByCountryMock
        case .recentRecipe:
            items = RecipeModel.mockData
        }
    }
}
