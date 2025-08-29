//
//  IHomeNetworking.swift
//  BestRecipes
//
//  Created by Келлер Дмитрий on 16.08.2025.
//

import Foundation

protocol IHomeNetworking {
    func fetchSearchRecipes(query: String) async throws -> [RecipeModel]
    func fetchTrendingNowRecipes(page: Int, perPage: Int) async throws -> (recipes: [RecipeModel], totalPages: Int)
    func fetchPopularCategoryRecipes(_ category: MealType, page: Int, perPage: Int) async throws -> (recipes: [RecipeModel], totalPages: Int)
    func fetchCuisineByCountries(_ country: Cuisine) async throws -> [RecipeModel]
}

final class HomeNetworking: IHomeNetworking {
    private let networkingService: NetworkingService
    
    init(networkingService: NetworkingService = NetworkingService()) {
        self.networkingService = networkingService
    }
    
    func fetchSearchRecipes(query: String) async throws -> [RecipeModel] {
        let endpoint = Endpoint.searchRecipes(query: query, number: 10)
        let response: Recipe = try await networkingService.fetch(from: endpoint)
        return response.results.map { $0.toUIModel() }
    }
    
    func fetchTrendingNowRecipes(page: Int, perPage: Int) async throws -> (recipes: [RecipeModel], totalPages: Int) {
        let offset = page * perPage
        let endpoint = Endpoint.trendingRecipes(number: perPage, offset: offset)
        let response: Recipe = try await networkingService.fetch(from: endpoint)
        let totalPages = Int(ceil(Double(response.totalResults) / Double(perPage)))
        return (response.results.map { $0.toUIModel() }, totalPages)
    }
    
    func fetchPopularCategoryRecipes(_ category: MealType, page: Int, perPage: Int) async throws -> (recipes: [RecipeModel], totalPages: Int) {
        let offset = page * perPage
        let endpoint = Endpoint.popularRecipes(number: perPage, offset: offset, minLikes: 100, mealType: category)
        let response: Recipe = try await networkingService.fetch(from: endpoint)
        let totalPages = Int(ceil(Double(response.totalResults) / Double(perPage)))
        return (response.results.map { $0.toUIModel() }, totalPages)
    }
    
    func fetchCuisineByCountries(_ country: Cuisine) async throws -> [RecipeModel] {
        let endpoint = Endpoint.popularRecipes(number: 10, cuisine: country)
        let response: Recipe = try await networkingService.fetch(from: endpoint)
        return response.results.map { $0.toUIModel() }
    }
}
