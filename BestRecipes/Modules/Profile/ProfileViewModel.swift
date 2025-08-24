//
//  ProfileViewModel.swift
//  BestRecipes
//
//  Created by Келлер Дмитрий on 24.08.2025.
//


import Foundation

@MainActor
final class ProfileViewModel: ObservableObject {
    @Published var createdRecipes: [RecipeModel] = []
    @Published var userName: String = "Best Recipes"
    @Published var profileImageName: String = ""
    
    init() {}
    
    func fetchcreatedRecipes(_ createdRecipes: [RecipeModel]) {
        self.createdRecipes = createdRecipes
    }
    
}
