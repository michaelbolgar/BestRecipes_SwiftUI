import Foundation

/**
 The service is implemented on the principle of CRUD -- create, read, update, delete. All the necessary methods can be implemented within the CRUD principle
*/

// need to check if we need Recipe or other struct

protocol UserDefaultsService {
    func hasCompletedOnboarding() -> Bool
    func getFavoriteRecipes() -> [Recipe]?

    func recordOnboardingIsCompleted()
    func save(recipe: Recipe, for key: Keys)

    func removeFromFavorites(recipeNumber: Int)
}

final class UserDefaultsServiceImpl: UserDefaultsService {
    private let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    // MARK: Create
    private func set(_ value: Any?, for key: Keys) {
        defaults.set(value, forKey: key.rawValue)
    }

    func recordOnboardingIsCompleted() {
        defaults.set(true, forKey: Keys.hasCompletedOnboarding.rawValue)
    }

    /// setter for recipes, favorites or recent
    func save(recipe: Recipe, for key: Keys) {
        var recipes: [Recipe] = []

        if let data = defaults.data(forKey: key.rawValue),
           let savedRecipes = try? JSONDecoder().decode([Recipe].self, from: data) {
            recipes = savedRecipes
        }
        recipes.append(recipe)

        if let data = try? JSONEncoder().encode(recipes) {
            defaults.set(data, forKey: key.rawValue)
        }
    }

    // MARK: Read
    private func bool(for key: Keys) -> Bool {
        defaults.bool(forKey: key.rawValue)
    }

    func hasCompletedOnboarding() -> Bool {
        defaults.bool(forKey: Keys.hasCompletedOnboarding.rawValue)
    }

    func getFavoriteRecipes() -> [Recipe]? {
        guard let data = defaults.data(forKey: Keys.favoriteRecipes.rawValue),
              let savedRecipes = try? JSONDecoder().decode([Recipe].self, from: data) else { return [] }
        return savedRecipes
    }

    // MARK: Update
    /// here can be methods for updating user's recipes

    // MARK: Delete
    func removeFromFavorites(recipeNumber: Int) {
        guard let data = defaults.data(forKey: Keys.favoriteRecipes.rawValue),
              var recipes = try? JSONDecoder().decode([Recipe].self, from: data) else { return }

        recipes.removeAll { $0.number == recipeNumber }

        if let newData = try? JSONEncoder().encode(recipes) {
            defaults.set(newData, forKey: Keys.favoriteRecipes.rawValue)
        }
    }
}
