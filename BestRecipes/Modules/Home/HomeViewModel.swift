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
    @Published var trendingNowRecipes: [RecipeModel] = []
    @Published var popularCategoryRecipes: [RecipeModel] = []
    @Published var cuisineByCountries: [RecipeModel] = []

    @Published var recentRecipes: [RecentRecipesModel] = []

    private var apiRecipes: [RecipeModel] = []
    
    private var isLoading = false

    // MARK: - Pagination State
    private var pages: [SeeAllType: Int] = [
        .trendingNow: 0,
        .popularCategories: 0
    ]
    private let perPage = 10
    
    @Published var currentCategory: MealType = .mainCourse {
        didSet {
            Task {
                await fetchPopularCategoryRecipes() 
            }
        }
    }

    let countries: [Cuisine] = Cuisine.allCases
    @Published var error: Error? = nil

    // MARK: - Init
    init(
        networkService: IHomeNetworking = HomeNetworking(),
        searchHistoryService: ISearchHistory = SearchHistoryService(),
        userDefaultsService: UserDefaultsService = UserDefaultsServiceImpl()
    ) {
        self.networkService = networkService
        self.searchHistoryService = searchHistoryService
        self.userDefaultsService = userDefaultsService
    
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
               let result = try await networkService.fetchTrendingNowRecipes(
                page: pages[.trendingNow] ?? 0,
                perPage: perPage
               )
               self.trendingNowRecipes = result.recipes
           } catch {
               self.error = error
           }
       }

       func fetchPopularCategoryRecipes() async {
           do {
               let result = try await networkService.fetchPopularCategoryRecipes(
                currentCategory,
                page: pages[.popularCategories] ?? 0,
                perPage: perPage
               )
               self.popularCategoryRecipes = result.recipes
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
        self.recentRecipes = recentRecipes.reversed()
    }

    // пока не используется, нужно приведение моделей
    func addRecentRecipe(_ recipe: RecentRecipesModel) {
        recentRecipes.removeAll(where: { $0.id == recipe.id })
        recentRecipes.insert(recipe, at: 0)
        // save into coredata
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
