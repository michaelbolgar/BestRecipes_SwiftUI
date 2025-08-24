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
    
    @Published var trendingNowRecipes: [RecipeModel] = []
    @Published var trendingNowBookable: [RecipeBookable] = []
    @Published var popularCategoryRecipes: [RecipeModel] = []
    @Published var recentRecipes: [RecentRecipesModel] = []
    @Published var cuisineByCountries: [RecipeModel] = []
    private var favorites: Set<Int> = []
    private var apiRecipes: [RecipeModel] = []

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
            self.trendingNowRecipes = recipes
        } catch {
            self.error = error
        }

        trendingNowBookable = trendingNowRecipes.map { recipe in
            var bookable = RecipeBookable(recipe: recipe)
            bookable.isBookmarked = favorites.contains(recipe.id)
            return bookable
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

    // MARK: Work with Saved recipes
    func toggleFavorite(for recipeID: Int) {
        if favorites.contains(recipeID) {
            favorites.remove(recipeID)
        } else {
            favorites.insert(recipeID)
        }
        userDefaultsService.saveFavorites(Array(favorites))

        if let index = trendingNowBookable.firstIndex(where: { $0.id == recipeID }) {
            trendingNowBookable[index].isBookmarked.toggle()
        }
    }

    private func loadFavorites() {
        let stored = userDefaultsService.loadFavorites()
        favorites = Set(stored)
    }
}
