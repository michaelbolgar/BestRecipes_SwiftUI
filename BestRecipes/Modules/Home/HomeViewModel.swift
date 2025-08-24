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
    private let userDefaultsService: UserDefaultsService

    private var currentSearchTask: Task<Void, Never>?

    @Published var searchText: String = "" {
        didSet {
            debounceSearchTask()
        }
    }
    
    @Published var searchResults: [RecipeModel] = []
    @Published var recentSearches: [String] = []

    /// models for fetching data from API
    @Published var trendingNowAPIRecipes: [RecipeModel] = []
    @Published var popularCategoryAPIRecipes: [RecipeModel] = []
    @Published var cuisineByCountriesAPI: [RecipeModel] = []
    @Published var recentRecipes: [RecentRecipesModel] = []

    /// models with added 'isFavorited' flag
    @Published var trendingNowRecipesFavoritable: [RecipeFavoritable] = []
    @Published var popularCategoryRecipesFavoritable: [RecipeFavoritable] = []
    @Published var cuisineByCountriesFavoritable: [RecipeFavoritable] = []

    private var apiRecipes: [RecipeModel] = []
    private var favorites: Set<Int> = []

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
        searchHistoryService: ISearchHistory = SearchHistoryService(),
        userDefaultsService: UserDefaultsService = UserDefaultsServiceImpl()
    ) {
        self.networkService = networkService
        self.searchHistoryService = searchHistoryService
        self.userDefaultsService = userDefaultsService
        loadFavorites()
        print("saved recipes by opening Home: \(favorites)")
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

    @MainActor
    func fetchTrendingNowRecipes() async {
        do {
            let recipes = try await networkService.fetchTrendingNowRecipes()
            self.trendingNowAPIRecipes = recipes
        } catch {
            self.error = error
        }

        trendingNowRecipesFavoritable = trendingNowAPIRecipes.map { recipe in
            var bookable = RecipeFavoritable(recipeDetails: recipe)
            bookable.isFavorited = favorites.contains(recipe.id)
            return bookable
        }
    }

    func fetchPopularCategoryRecipes() async {
        do {
            let recipes = try await networkService.fetchPopularCategoryRecipes(currentCategory)
            self.popularCategoryAPIRecipes = recipes
        } catch {
            self.error = error
        }

        popularCategoryRecipesFavoritable = popularCategoryAPIRecipes.map { recipe in
            var bookable = RecipeFavoritable(recipeDetails: recipe)
            bookable.isFavorited = favorites.contains(recipe.id)
            return bookable
        }
    }
    
    func fetchCuisineByCountries(_ currentCountry: Cuisine) async {
        do {
            cuisineByCountriesAPI = try await networkService.fetchCuisineByCountries(currentCountry)
        } catch {
            self.error = error
        }

        cuisineByCountriesFavoritable = cuisineByCountriesAPI.map { recipe in
            var bookable = RecipeFavoritable(recipeDetails: recipe)
            bookable.isFavorited = favorites.contains(recipe.id)
            return bookable
        }
    }
    
    
    func fetchRecentRecipe(_ recentRecipes: [RecentRecipesModel]) {
        self.recentRecipes = recentRecipes
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

    // MARK: Work with Favorite recipes
    func toggleFavorite(for recipeID: Int, type: SeeAllType) {
        if favorites.contains(recipeID) {
            favorites.remove(recipeID)
        } else {
            favorites.insert(recipeID)
        }
        userDefaultsService.saveFavorites(Array(favorites))

        switch type {
        case .trendingNow:
            syncFavorites(in: &trendingNowRecipesFavoritable, recipeID: recipeID)
        case .popularCategories:
            syncFavorites(in: &popularCategoryRecipesFavoritable, recipeID: recipeID)
        case .cuisineByCountry:
            syncFavorites(in: &cuisineByCountriesFavoritable, recipeID: recipeID)
        case .recentRecipe:
            syncFavorites(in: &trendingNowRecipesFavoritable, recipeID: recipeID) // mock
        }
    }

    /// func for updating UI (coloring bookmark) in collecions in runtime
    private func syncFavorites(in collection: inout [RecipeFavoritable], recipeID: Int) {
        if let index = collection.firstIndex(where: { $0.id == recipeID }) {
            collection[index].isFavorited = favorites.contains(recipeID)
        }
    }


    private func loadFavorites() {
        let stored = userDefaultsService.loadFavorites()
        favorites = Set(stored)
    }
}
