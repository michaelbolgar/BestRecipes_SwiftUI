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
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(MealType.allCases, id: \.self) { category in
                        CategoryButton(
                            categoryName: category.displayName,
                            isSelected: category == selectedCategory,
                            onTap: {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    selectedCategory = category
                                    onCategorySelected(category)
                                    proxy.scrollTo(category, anchor: .center)
                                }
                            }
                        )
                        .id(category) 
                        .clipShape(RoundedRectangle(cornerRadius: Offsets.x2))
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }
}

#Preview {
    CategoryButtonCell(onCategorySelected: {_ in })
}
