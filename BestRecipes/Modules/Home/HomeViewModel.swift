import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
    // MARK: - Properties
    private let networkService: HomeNetworkingProtocol
    private let searchHistoryService: SearchHistoryProtocol

    @Published var searchText: String = "" {
        didSet { debounceSearchTask() }
    }
    
    @Published private(set) var searchResults: [RecipeModel] = []
    @Published private(set) var recentSearches: [String] = []

    /// models for fetching data from API
    @Published private(set) var trendingNowRecipes: [RecipeModel] = []
    @Published private(set) var popularCategoryRecipes: [RecipeModel] = []
    @Published private(set) var cuisineByCountries: [RecipeModel] = []
    @Published private(set) var recentRecipes: [RecentRecipesModel] = []

    @Published var error: Error?

    @Published var currentCategory: MealType = .mainCourse {
        didSet {
            Task { [weak self] in
                await self?.fetchPopularCategoryRecipes()
            }
        }
    }

    private var currentSearchTask: Task<Void, Never>?
    private var pages: [SeeAllType: Int] = [.trendingNow: 0, .popularCategories: 0]
    private let perPage = 10

    private var apiRecipes: [RecipeModel] = []
    private var isLoading = false

    let countries: [Cuisine] = Cuisine.allCases

    // MARK: - Init
    init(
        networkService: HomeNetworkingProtocol,
        searchHistoryService: SearchHistoryProtocol,
    ) {
        self.networkService = networkService
        self.searchHistoryService = searchHistoryService
    }
    
    // MARK: - Fetch Data
    func loadInitialData() async {
        await withTaskGroup(of: Void.self) { group in
            group.addTask { await self.fetchTrendingNowRecipes() }
            group.addTask { await self.fetchPopularCategoryRecipes() }
        }
    }

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
        if recentRecipes.count > 10 {
            recentRecipes.removeLast()
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
