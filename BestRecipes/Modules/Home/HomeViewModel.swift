//
//  HomeViewModel.swift
//  BestRecipes
//
//  Created by Келлер Дмитрий on 13.08.2025.
//

import Foundation


final class HomeViewModel: ObservableObject {
    
    @Published var searchText: String = ""
    @Published var trendingNowRecipes: [RecipeModel] = []
    @Published var popularCategoryRecipes: [RecipeModel] = []
    @Published var cuisineByCountrys: [RecipeModel] = []
    
    
    // MARK: - Init
    init() {
     
    }
    
}
