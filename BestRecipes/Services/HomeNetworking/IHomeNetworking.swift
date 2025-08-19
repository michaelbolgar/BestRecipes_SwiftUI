//
//  IHomeNetworking.swift
//  BestRecipes
//
//  Created by Келлер Дмитрий on 16.08.2025.
//

import Foundation

protocol IHomeNetworking {
    func fetchSearchRecipes(query: String) async throws -> [RecipeModel]
    func fetchTrendingNowRecipes() async throws -> [RecipeModel]
    func fetchPopularCategoryRecipes(_ category: MealType) async throws -> [RecipeModel]
    func fetchCuisineByCountries(_ country: Cuisine) async throws -> [RecipeModel]
}

final class HomeNetworking: IHomeNetworking {
    private let networkingService: NetworkingService
    
    init(networkingService: NetworkingService = NetworkingService()) {
        self.networkingService = networkingService
    }
    
    func fetchSearchRecipes(query: String) async throws -> [RecipeModel] {
        let endpoint = Endpoint.searchRecipes(query: query, number: 10)
        print(endpoint)
        let response: Recipe = try await networkingService.fetch(from: endpoint)
        print(response)
        return response.results.map { $0.toUIModel() }
    }
    
    func fetchTrendingNowRecipes() async throws -> [RecipeModel] {
        let endpoint = Endpoint.trendingRecipes(number: 10, days: 7)
        let response: Recipe = try await networkingService.fetch(from: endpoint)
        return response.results.map { $0.toUIModel() }
    }
    
    func fetchPopularCategoryRecipes(_ category: MealType) async throws -> [RecipeModel] {
        let endpoint = Endpoint.popularRecipes(number: 10, minLikes: 100, mealType: category)
        let response: Recipe = try await networkingService.fetch(from: endpoint)
        return response.results.map { $0.toUIModel() }
    }
    
    func fetchCuisineByCountries(_ country: Cuisine) async throws -> [RecipeModel] {
        let endpoint = Endpoint.popularRecipes(number: 10, cuisine: country)
        let response: Recipe = try await networkingService.fetch(from: endpoint)
        return response.results.map { $0.toUIModel() }
    }
}
