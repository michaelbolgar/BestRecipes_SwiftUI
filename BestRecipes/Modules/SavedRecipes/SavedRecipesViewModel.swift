import SwiftUI

final class SavedRecipesViewModel: ObservableObject {

    // MARK: Properties
    @Published var savedRecipes: [RecipeFavoritable] = []
    @Published var favorites: Set<Int> = []

    private let networkingService: NetworkingService
    private let userDefaultsService: UserDefaultsService

    @Published var error: Error? = nil

    // MARK: Init
    init(
        networkingService: NetworkingService = NetworkingService(),
        userDefaultsService: UserDefaultsService = UserDefaultsServiceImpl()
    ) {
        self.networkingService = networkingService
        self.userDefaultsService = userDefaultsService
        loadFavorites()
        print("saved recipes in saved: \(favorites)")
    }

    // MARK: Load favorites from UserDefaults
    func loadFavorites() {
        let savedIDs = userDefaultsService.loadFavorites()
        favorites = Set(savedIDs)

        Task {
            await fetchSavedRecipes()
        }
    }

    // MARK: Toggling favorites
    func toggleFavorite(for recipeID: Int) {
        if favorites.contains(recipeID) {
            favorites.remove(recipeID)
        } else {
            favorites.insert(recipeID)
        }
        userDefaultsService.saveFavorites(Array(favorites))

        Task {
            await fetchSavedRecipes()
        }
    }

    // MARK: - Fetch saved
    @MainActor
    private func fetchSavedRecipes() async {
        guard !favorites.isEmpty else {
            savedRecipes = []
            return
        }

        do {
            var fetched: [RecipeFavoritable] = []

            let favoriteIDs = Array(favorites)
            for id in favoriteIDs {
                let result: DetailedRecipe = try await networkingService.fetch(from: .getRecipeInformation(id: id))
                let mapped = result.toFavoritable(isFavorited: true)
                fetched.append(mapped)
            }

            savedRecipes = fetched.reversed()
            print(savedRecipes)
        } catch {
            self.error = error
            print("Error fetching saved recipes: \(error)")
        }
    }
}
