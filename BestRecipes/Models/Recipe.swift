//
//  Recipe.swift
//  BestRecipes
//
//  Created by Alexander Abanshin on 12.08.2025.
//

import Foundation

struct Recipe: Codable {
    let number: Int
    let totalResults: Int
    let results: [Result]
   
}

struct Result: Codable {
    let id: Int
    let title: String
    let image: URL?
    let spoonacularScore: Double?
    let readyInMinutes: Int?
    let creditsText: String?
    
    /// Рейтинг от 0 до 5, как в макете. С API приходит 0...100.
    var scoreOutOfFive: Double {
        let rawScore = ((spoonacularScore ?? 0) / 100) * 5
        return (rawScore * 2).rounded() / 2
    }
   
    func toUIModel() -> RecipeModel {
        RecipeModel(
            id: id,
            title: title,
            image: image ?? URL(string: "https://placehold.co/150x150/cccccc/000000.png?font=arial&text=No+photo")!,
            author: creditsText ?? "Unknown",
            spoonacularScore: (spoonacularScore ?? 0) / 100 * 5,
            readyInMinutes: "\(readyInMinutes ?? 0) min"
        )
    }
    
}
