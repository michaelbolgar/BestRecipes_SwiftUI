//
//  CategoryScroll.swift
//  BestRecipes
//
//  Created by Келлер Дмитрий on 13.08.2025.
//


import SwiftUI

struct CategoryButtonCell: View {
    // MARK: - Properties
    @State private var selectedCategory: MealType = .mainCourse
    
    let onCategorySelected: (MealType) -> Void
    
    // MARK: - Body
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(MealType.allCases) { category in
                    CategoryButton(
                        categoryName: category.displayName,
                        isSelected: category == selectedCategory,
                        onTap: {
                            selectedCategory = category
                            onCategorySelected(category)
                        }
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
