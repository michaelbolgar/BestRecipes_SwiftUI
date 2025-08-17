//
//  RecipeDetailView.swift
//  BestRecipes
//
//  Created by KOZLOVA Anastasia on 14.08.2025.
//

import SwiftUI

final class RecipeDetailViewModel: ObservableObject {
    @Published var items: RecipeDetailModelMock = RecipeDetailModelMock.mockData
    
    let recipeID: Int
    
    init(recipeID: Int) {
        self.recipeID = recipeID
        loadItems()
    }
    
    private func loadItems() {
        items = RecipeDetailModelMock.mockData
    }
}
