//
//  SeeAllViewModel.swift
//  BestRecipes
//
//  Created by Sergey Zakurakin on 8/13/25.
//

//import Foundation
//
//final class SeeAllViewModel: ObservableObject {
//    @Published var items: [RecipeBookable] = []
//    let type: SeeAllType
//    
//    init(type: SeeAllType, items: [RecipeBookable]) {
//        self.type = type
//        self.items = items
//    }
//
//    private func loadItems() {
//        switch type {
//        case .trendingNow:
//            items = RecipeBookable.trendingMockBookable
//        case .popularCategories:
//            items = RecipeBookable.trendingMockBookable
//        case .cuisineByCountry:
//            items = RecipeBookable.trendingMockBookable
//        case .recentRecipe:
//            items = RecipeBookable.trendingMockBookable
//        }
//    }
//}
