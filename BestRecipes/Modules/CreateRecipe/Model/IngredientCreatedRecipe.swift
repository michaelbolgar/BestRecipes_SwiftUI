//
//  IngredientCreatedRecipe.swift
//  BestRecipes
//
//  Created by Келлер Дмитрий on 24.08.2025.
//

import Foundation

struct IngredientCreatedRecipe: Identifiable {
    let id = UUID()
    var name: String
    var quantity: String
}
