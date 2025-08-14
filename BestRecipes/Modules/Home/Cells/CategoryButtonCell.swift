//
//  CategoryScroll.swift
//  BestRecipes
//
//  Created by Келлер Дмитрий on 13.08.2025.
//


import SwiftUI

struct CategoryButtonCell: View {
    // MARK: - Properties
    @State private var selectedCategoryId: Int = 1
    
    let onCategorySelected: (CategoryModel) -> Void
    
    private let categoryNames = ["Main course", "Side dish", "Dessert", "Appetizer", "Salad", "Bread", "Breakfast", "Soup", "Beverage", "Sauce", "Marinade", "Fingerfood", "Snack", "Drink"]
    
    private var categories: [CategoryModel] {
        categoryNames.enumerated().map { index, name in
            CategoryModel(id: index, name: name)
        }
    }
    
    // MARK: - Body
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(categories) { category in
                    CategoryButton(
                        categoryName: category.name,
                        isSelected: category.id == selectedCategoryId,
                        onTap: {
                            selectedCategoryId = category.id
                            onCategorySelected(category)
                        },
                        
                    )
                    .clipShape(RoundedRectangle(cornerRadius: Offsets.x2))
                }
                .clipped()
            }
        }
    }
}

#Preview {
    CategoryButtonCell(onCategorySelected: {_ in })
}
