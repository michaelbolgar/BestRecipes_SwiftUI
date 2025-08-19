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
    let recipeID: Int
    
    init(recipeID: Int, networkService: NetworkingService = NetworkingService()) {
        self.recipeID = recipeID
        self.networkService = networkService
    }

  // MARK: - Fetch Data
  func fetchRecipeDetails() async {
    do {
      let result: DetailedRecipe = try await networkService.fetch(from: .getRecipeInformation(id: recipeID))
      await MainActor.run {
        self.items = result
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
