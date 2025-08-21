//
//  HomeViewModel.swift
//  BestRecipes
//
//  Created by Келлер Дмитрий on 13.08.2025.
//

import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
    // MARK: - Properties
    private let networkService: IHomeNetworking
    private let searchHistoryService: ISearchHistory
    
    private var currentSearchTask: Task<Void, Never>?
    
    @Published var searchText: String = "" {
        didSet {
            debounceSearchTask()
        }
    }
    
    @Published var searchResults: [RecipeModel] = []
    @Published var recentSearches: [String] = []
    
    @Published var trendingNowRecipes: [RecipeModel] = []
    @Published var popularCategoryRecipes: [RecipeModel] = []
    @Published var cuisineByCountries: [RecipeModel] = []
    
    @Published var currentCategory: MealType = .mainCourse {
        didSet {
            Task {
                await  fetchPopularCategoryRecipes()
            }
        }
    }
    
    @Published var error: Error? = nil
    
    let countries: [Cuisine] = Cuisine.allCases
    // MARK: - Init
    init(
        networkService: IHomeNetworking = HomeNetworking(),
        searchHistoryService: ISearchHistory = SearchHistoryService()
    ) {
        self.networkService = networkService
        self.searchHistoryService = searchHistoryService
    }
    
    // MARK: - Fetch Data
    
    func fetchSearchRecipes() async {
        do {
            addSearchQuery(searchText)
            searchResults = try await networkService.fetchSearchRecipes(query: searchText)
        } catch {
            self.error = error
        }
    }
    
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
    
    // MARK: - Вebounce Search Task
    private func debounceSearchTask() {
        currentSearchTask?.cancel()
        currentSearchTask = Task {
            try? await Task.sleep(nanoseconds: 300_000_000)
            guard !Task.isCancelled else { return }

            if searchText.count > 2 {
                await fetchSearchRecipes()
            } else {
                searchResults = []
            }
        }
    }
    
    func addSearchQuery(_ query: String) {
        searchHistoryService.saveQuery(query)
        loadRecentSearches()
    }
    
    func loadRecentSearches() {
        recentSearches = searchHistoryService.loadHistory()
    }
    
    func clearRecentSearches(_ query: String) {
        searchHistoryService.clearRecentSearches(query)
        recentSearches.removeAll(where: { $0 == query })
    }
}
