//
//  HomeViewModel.swift
//  BestRecipes
//
//  Created by Келлер Дмитрий on 13.08.2025.
//

import Foundation


@MainActor
final class HomeViewModel: ObservableObject {
    private let networkService: IHomeNetworking
    
    @Published var searchText: String = ""
    @Published var searchResults: [RecipeModel] = []
    @Published var recentSearches: [String] = []
    
    @Published var trendingNowRecipes: [RecipeModel] = []
    @Published var popularCategoryRecipes: [RecipeModel] = []
    @Published var cuisineByCountries: [RecipeModel] = []
    
    @Published var currentCategory: MealType = .mainCourse {
        didSet {
            Task {
                await fetchPopularCategoryRecipes()
            }
        }
    }
    

    @Published var error: Error? = nil
    
    let countries: [Cuisine] = Cuisine.allCases
    // MARK: - Init
    init(networkService: IHomeNetworking = HomeNetworking()) {
        self.networkService = networkService

    }
    
    // MARK: - Fetch Data
    func fetchTrendingNowRecipes() async {
        do {
            trendingNowRecipes = try await networkService.fetchTrendingNowRecipes()
        } catch {
            self.error = error
        }
    }
    
    func fetchPopularCategoryRecipes() async {
        do {
            popularCategoryRecipes = try await networkService.fetchPopularCategoryRecipes(currentCategory)
        } catch {
            self.error = error
        }
    }
    
    func fetchCuisineByCountries(_ currentCountry: Cuisine) async {
        do {
            cuisineByCountries = try await networkService.fetchCuisineByCountries(currentCountry)
        } catch {
            self.error = error
        }
    }
    
//    MARK: - Search Methods
    
    func filteredRecipes() -> [RecipeModel] {
        if searchText.isEmpty { return searchResults }
        return searchResults.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
    }
    
    func getSuggestions() -> [String] {
        if searchText.isEmpty {
            return recentSearches.reversed()
        }
        let filteredResults = searchResults
            .map { $0.title }
            .filter { $0.localizedCaseInsensitiveContains(searchText) }
        
        return Array(filteredResults.prefix(8))
    }
    
    
}
