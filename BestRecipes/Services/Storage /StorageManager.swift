//
//  StorageManager.swift
//  BestRecipes
//
//  Created by Alexander Abanshin on 18.08.2025.
//

import Foundation

final class StorageManager {
    static let shared = StorageManager()
    private let userDefaults = UserDefaults.standard
    

    private let recipeKey = "recipeKey"
    private let boolKey = "boolKey"
    
    
    private init() {}
    
    // MARK: - Recipe
    
    func save(recipe: Recipe) {
        guard let data = try? JSONEncoder().encode(recipe) else { return }
        userDefaults.set(data, forKey: recipeKey)
    }
    
    func getRecipe() -> Recipe? {
        guard let data = userDefaults.data(forKey: recipeKey) else { return nil }
        return try? JSONDecoder().decode(Recipe.self, from: data)
    }
    
    func deleteRecipe() {
        userDefaults.removeObject(forKey: recipeKey)
    }
    
    // MARK: - Bool
    
    func save(isFirstLaunch: Bool) {
        userDefaults.set(isFirstLaunch, forKey: boolKey)
    }
    
    func getIsFirstLaunch() -> Bool {
        return userDefaults.bool(forKey: boolKey)
    }
    
    func deleteIsFirstLaunch() {
        userDefaults.removeObject(forKey: boolKey)
    }
}
