//
//  CreatedRecipeModel.swift
//  BestRecipes
//
//  Created by Келлер Дмитрий on 24.08.2025.
//

import Foundation

struct CreatedRecipeModel: Identifiable {
    let id: UUID
    let title: String
    let serves: Int
    let cookTime: String
    let ingredients: [String: String]
    let imageData: Data?
}

extension CreatedRecipeModel {
    init(entity: CreatedRecipeEntity) {
        self.id = entity.id ?? UUID()
        self.title = entity.title ?? ""
        self.serves = Int(entity.serves)
        self.cookTime = entity.cookTime ?? ""
        self.ingredients = (entity.ingredients as? [String: String]) ?? [:]
        self.imageData = entity.imageData
    }
}
