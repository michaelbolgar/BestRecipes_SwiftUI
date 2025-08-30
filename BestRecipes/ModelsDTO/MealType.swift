//
//  MealType.swift
//  BestRecipes
//
//  Created by Alexander Abanshin on 14.08.2025.
//

import Foundation

enum MealType: String, CaseIterable, Identifiable {
    case mainCourse = "main course"
    case sideDish = "side dish"
    case dessert
    case appetizer
    case salad
    case bread
    case breakfast
    case soup
    case beverage
    case sauce
    case marinade
    case fingerfood
    case snack
    case drink
    
    var id: String { rawValue }
    
    var displayName: String {
        rawValue.capitalized
    }
}
