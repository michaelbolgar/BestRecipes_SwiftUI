//
//  RecipeDetailModelMock.swift
//  BestRecipes
//
//  Created by KOZLOVA Anastasia on 14.08.2025.
//

import Foundation

struct RecipeDetailModelMock: Identifiable {
    let id: Int
    let title: String
    let image: URL
    let mark: Double
    let numbersOfReviews: Int
    let instructionText: String
    let ingredients: [IngredientMock]
}

struct IngredientMock: Identifiable {
  var id: Int
  let name: String
  let image: URL
  let weight: Int
}

extension RecipeDetailModelMock {
  /// Массив моковых рецептов
  static let mockData: RecipeDetailModelMock =
  RecipeDetailModelMock(
      id: 1,
      title: "Spaghetti Carbonara",
      image: URL(string: "https://spoonacular.com/recipeImages/716429-312x231.jpg")!,
      mark: 4.5,
      numbersOfReviews: 200,
      instructionText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam auctor quam id massa faucibus dignissim. Nullam eget metus id nisl malesuada condimentum. Nam viverra fringilla erat, ut fermentum nunc feugiat eu.",
      ingredients: [IngredientMock(id: 1, name: "Fish", image: URL(string: "https://spoonacular.com/recipeImages/716429-312x231.jpg")!, weight: 250), IngredientMock(id: 2, name: "Eggs", image: URL(string: "https://spoonacular.com/recipeImages/716429-312x231.jpg")!, weight: 200),IngredientMock(id: 3, name: "Parmesan", image: URL(string: "https://spoonacular.com/recipeImages/716429-312x231.jpg")!, weight: 100), IngredientMock(id: 4, name: "Parmesan", image: URL(string: "https://spoonacular.com/recipeImages/716429-312x231.jpg")!, weight: 100), IngredientMock(id: 5, name: "Parmesan", image: URL(string: "https://spoonacular.com/recipeImages/716429-312x231.jpg")!, weight: 100), IngredientMock(id: 6, name: "Parmesan", image: URL(string: "https://spoonacular.com/recipeImages/716429-312x231.jpg")!, weight: 100)]
    )
}
