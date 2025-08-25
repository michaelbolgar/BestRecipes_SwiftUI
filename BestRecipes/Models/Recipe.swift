//
//  Recipe.swift
//  BestRecipes
//
//  Created by Alexander Abanshin on 12.08.2025.
//

import Foundation

struct Recipe: Codable {
    let offset: Int
    let number: Int
    let totalResults: Int
    let results: [Result]
   
}

struct Result: Codable {
    let id: Int
    let title: String
    let image: URL
    let spoonacularScore: Double
    let readyInMinutes: Int
    let creditsText: String
    
    /// Рейтинг от 0 до 5, как в макете. С API приходит 0...100.
    var scoreOutOfFive: Double {
        let rawScore = (spoonacularScore / 100) * 5
        return (rawScore * 2).rounded() / 2
    }
    
    func toUIModel() -> RecipeModel {
        RecipeModel(
            id: id,
            title: title,
            image: image,
            author: creditsText,
            spoonacularScore: scoreOutOfFive,
            readyInMinutes: "\(String(describing: readyInMinutes)) min"
        )
    }
    
}
