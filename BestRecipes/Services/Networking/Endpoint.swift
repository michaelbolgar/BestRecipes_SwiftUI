//
//  Endpoint.swift
//  BestRecipes
//
//  Created by Alexander Abanshin on 12.08.2025.
//

import Foundation

enum Endpoint {
     /// Получение рецептов по поисковому запросу
    case searchRecipes(query: String, number: Int)
    /// Получение популярных рецептов (сортировка по количеству лайков)
    /// - Parameters:
    ///   - number: Максимальное количество возвращаемых рецептов (1-100)
    ///   - minLikes: Минимальное количество лайков (по умолчанию 100)
    ///   - mealType: Тип блюда (например, "breakfast", "salad"), опционально
    ///   - cuisine: Кухня (например, "Italian", "Mexican"), опционально
    case popularRecipes(number: Int, minLikes: Int = 100, mealType: MealType? = nil, cuisine: Cuisine? = nil)
    /// Получение трендовых рецептов (сортировка по дате добавления)
    /// - Parameters:
    ///   - number: Максимальное количество возвращаемых рецептов (1-100)
    ///   - days: За последнее количество дней (по умолчанию 7)
    case trendingRecipes(number: Int, days: Int = 7)
    /// Получение детальной информации о конкретном рецепте
    /// - Parameters:
    ///   - id: Уникальный идентификатор рецепта
    case getRecipeInformation(id: Int)
    /// Получение картинки для рецепта
    /// - Parameters:
    ///   - imageName: Эндпоинт картинки
    case getIngredientImage(imageName: String)
    
    var baseURL: String {
        return "https://api.spoonacular.com"
    }
  
    var baseImgURL: String {
      return "https://img.spoonacular.com"
    }
    
    var path: String {
        switch self {
        case .searchRecipes:
            return "/recipes/complexSearch"
        case .popularRecipes, .trendingRecipes:
            return "/recipes/complexSearch"
        case .getRecipeInformation(let id):
            return "/recipes/\(id)/information"
        case .getIngredientImage(imageName: let imageName):
            return "/ingredients_100x100/\(imageName)"
        }
    }
    
    var queryItems: [URLQueryItem] {
        var items = [URLQueryItem(name: "apiKey", value: API.apiKey.rawValue)]

        switch self {
        case .searchRecipes(let query, let number):
            items.append(contentsOf: [
                URLQueryItem(name: "sort", value: "popularity"),
                URLQueryItem(name: "addRecipeInformation", value: "true"),
                URLQueryItem(name: "number", value: "\(number)"),
                URLQueryItem(name: "query", value: "\(query)")
                ])
        case .popularRecipes(let number, let minLikes, let mealType, let cuisine):
            items.append(contentsOf: [
                URLQueryItem(name: "sort", value: "popularity"),
                URLQueryItem(name: "number", value: "\(number)"),
                URLQueryItem(name: "minLikes", value: "\(minLikes)"),
                URLQueryItem(name: "addRecipeInformation", value: "true")
            ])
            
            if let mealType = mealType {
                items.append(URLQueryItem(name: "type", value: mealType.rawValue))
            }
            if let cuisine = cuisine {
                items.append(URLQueryItem(name: "cuisine", value: cuisine.rawValue))
            }
            
        case .trendingRecipes(let number, let days):
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from: Calendar.current.date(byAdding: .day, value: -days, to: Date())!)
            
            items.append(contentsOf: [
                URLQueryItem(name: "sort", value: "date"),
                URLQueryItem(name: "number", value: "\(number)"),
                URLQueryItem(name: "minDate", value: dateString),
                URLQueryItem(name: "addRecipeInformation", value: "true")
            ])
            
        case .getRecipeInformation, .getIngredientImage:
           break
        }
        
        return items
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .searchRecipes, .popularRecipes, .trendingRecipes, .getRecipeInformation, .getIngredientImage:
            return .get
        }
    }

}
