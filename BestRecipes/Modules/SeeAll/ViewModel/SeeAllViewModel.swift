//
//  SeeAllViewModel.swift
//  BestRecipes
//
//  Created by Sergey Zakurakin on 8/13/25.
//

import Foundation

final class SeeAllViewModel: ObservableObject {
    @Published var items: [RecipeModel] = []
    let type: SeeAllType
    
    init(type: SeeAllType, items: [RecipeModel]) {
        self.type = type
        self.items = items
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
