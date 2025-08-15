//
//  RecipeDetailView.swift
//  BestRecipes
//
//  Created by KOZLOVA Anastasia on 14.08.2025.
//

import SwiftUI

final class RecipeDetailViewModel: ObservableObject {
  @Published var items: RecipeDetailModelMock = RecipeDetailModelMock.mockData
  
  init() {
    loadItems()
  }
  
  private func loadItems() {
    items = RecipeDetailModelMock.mockData
  }
}
