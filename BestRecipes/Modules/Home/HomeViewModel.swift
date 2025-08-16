//
//  HomeViewModel.swift
//  BestRecipes
//
//  Created by Келлер Дмитрий on 13.08.2025.
//

import Foundation


final class HomeViewModel: ObservableObject {

    @Published var searchText: String = ""
    @Published var trendingNowRecipes: [RecipeModel] = RecipeModel.trendingMock
    @Published var popularCategoryRecipes: [RecipeModel] = RecipeModel.popularCategoryMock
    @Published var cuisineByCountries: [RecipeModel] = RecipeModel.cuisineByCountryMock
    
    
    // MARK: - Init
    init() {
     
    }
}
