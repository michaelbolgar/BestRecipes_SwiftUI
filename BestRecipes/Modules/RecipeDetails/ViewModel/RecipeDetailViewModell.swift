//
//  RecipeDetailView.swift
//  BestRecipes
//
//  Created by KOZLOVA Anastasia on 14.08.2025.
//

import SwiftUI

final class RecipeDetailViewModel: ObservableObject {
    @Published var items: DetailedRecipe?
    @Published var ingredientImage: [Int: UIImage] = [:]
    @Published var error: Error? = nil
    private var networkService: NetworkingService
    private var coreDataService: CoreDataService?
    let recipeID: Int
    
    init(recipeID: Int, networkService: NetworkingService = NetworkingService()) {
        self.recipeID = recipeID
        self.networkService = networkService
    }
    
    func setCoreDataService(_ service: CoreDataService) {
        self.coreDataService = service
    }
    
    // MARK: - Fetch Data
    func fetchRecipeDetails() async {
        do {
            let result: DetailedRecipe = try await networkService.fetch(from: .getRecipeInformation(id: recipeID))
            await MainActor.run {
                self.items = result
                if let coreDataService {
                    let recentRecipe = RecentRecipesModel(from: result)
                    coreDataService.createRecentRecipe(recipe: recentRecipe)
                }
            }
        } catch {
            await MainActor.run {
                self.error = error
            }
        }
    }
    
    func fetchIngredientImage(imageName: String, id: Int) async {
        do {
            let result: Data = try await networkService.fetch(from: .getIngredientImage(imageName: imageName))
            if let image = UIImage(data: result) {
                await MainActor.run {
                    self.ingredientImage[id] = image
                }
            }
        } catch {
            await MainActor.run {
                self.error = error
            }
        }
    }
}
