//
//  Endpoint.swift
//  BestRecipes
//
//  Created by Alexander Abanshin on 12.08.2025.
//

import Foundation

enum Endpoint {
    /// Получение популярных рецептов (сортировка по количеству лайков)
    /// - Parameters:
    ///   - number: Максимальное количество возвращаемых рецептов (1-100)
    ///   - minLikes: Минимальное количество лайков (по умолчанию 100)
    ///   - mealType: Тип блюда (например, "breakfast", "salad"), опционально
    case popularRecipes(number: Int, minLikes: Int = 100, mealType: String? = nil)
    /// Получение трендовых рецептов (сортировка по дате добавления)
    /// - Parameters:
    ///   - number: Максимальное количество возвращаемых рецептов (1-100)
    ///   - days: За последнее количество дней (по умолчанию 7)
    case trendingRecipes(number: Int, days: Int = 7)
    /// Получение детальной информации о конкретном рецепте
    /// - Parameters:
    ///   - id: Уникальный идентификатор рецепта
    case getRecipeInformation(id: Int)
    
    var baseURL: String {
        return "https://api.spoonacular.com"
    }
    
    var path: String {
        switch self {
        case .popularRecipes, .trendingRecipes:
            return "/recipes/complexSearch"
        case .getRecipeInformation(let id):
            return "/recipes/\(id)/information"
        }
    }
    
    var queryItems: [URLQueryItem] {
        var items = [URLQueryItem(name: "apiKey", value: API.apiKey)]
        
        switch self {
        case .popularRecipes(let number, let minLikes, let mealType):
            items.append(contentsOf: [
                URLQueryItem(name: "sort", value: "popularity"),
                URLQueryItem(name: "number", value: "\(number)"),
                URLQueryItem(name: "minLikes", value: "\(minLikes)"),
                URLQueryItem(name: "addRecipeInformation", value: "true")
            ])
            
            if let mealType = mealType {
                items.append(URLQueryItem(name: "type", value: mealType))
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
            
        case .getRecipeInformation:
           break
        }
        
        return items
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .popularRecipes, .trendingRecipes, .getRecipeInformation:
            return .get
        }
    }

}
