//
//  DetailedRecipe.swift
//  BestRecipes
//
//  Created by Alexander Abanshin on 12.08.2025.
//

import Foundation

struct DetailedRecipe: Decodable {
    let id: Int
    let title: String
    let image: URL
    let readyInMinutes: Int
    let aggregateLikes: Double
    let spoonacularScore: Double
    let analyzedInstructions: [AnalyzedInstruction]
    let extendedIngredients: [Ingredient]
}

struct Ingredient: Decodable, Identifiable {
    let id: Int
    let name: String
    let original: String
    let image: String
    let measures: Measures
}

struct Measures: Decodable {
  let metric: Measure
  
  struct Measure: Decodable {
    let amount: Double
    let unitShort: String
  }
}

struct AnalyzedInstruction: Decodable {
  let steps: [Step]
  
  struct Step: Decodable, Identifiable {
    let number: Int
    let step: String
    
    var id: Int { number }
  }
}

extension DetailedRecipe {
    /// Вычисляемый рейтинг (0-5) на основе spoonacularScore
    var scoreOutOfFive: Double {
        let rawScore = (spoonacularScore / 100) * 5
        return (rawScore * 2).rounded() / 2
    }
}

