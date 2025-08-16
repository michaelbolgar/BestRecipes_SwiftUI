//
//  HomeViewModel.swift
//  BestRecipes
//
//  Created by Келлер Дмитрий on 13.08.2025.
//

import Foundation


final class HomeViewModel: ObservableObject {
    private let networkService = NetworkingService()
    
    @Published var searchText: String = ""
    @Published var trendingNowRecipes: [RecipeModel] = RecipeModel.trendingMock
    @Published var popularCategoryRecipes: [RecipeModel] = RecipeModel.popularCategoryMock
    @Published var cuisineByCountries: [RecipeModel] = RecipeModel.cuisineByCountryMock
    
    @Published var currentCategory: String? = nil
    
    @Published var error: Error? = nil
    
    // MARK: - Init
    init() {
     
    }
    
    // MARK: - Fetch Data
    func fetchTrendingNowRecipes() {
        do {
            let result = 
        } catch {
            self.error = error.localizedDescription
        }
    }
    
    func fetchPopularCategoryRecipes() {
        do {
            
        } catch {
            self.error = error.localizedDescription
        }
    }
    
    func fetchCuisineByCountries() {
        do {
            
        } catch {
            self.error = error.localizedDescription
        }
    }
  
}
