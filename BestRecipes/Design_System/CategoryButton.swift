//
//  CategoryButton.swift
//  BestRecipes
//
//  Created by Келлер Дмитрий on 13.08.2025.
//


import SwiftUI

struct CategoryButton: View {
    let categoryName: String
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button {
            onTap()
        } label: {
            Text(categoryName)
                .recipesCategoryButtonStyle()
                .foregroundColor(isSelected ? .appBackground : .redPrimary20)
                .padding(.horizontal, Offsets.x3)
                .frame(height: Offsets.x9)
                .background(isSelected ? .redPrimary50 : .appWhite)
                .clipShape(RoundedRectangle(cornerRadius: Offsets.x3))
                .animation(.easeInOut(duration: 0.2), value: isSelected)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    VStack {
        CategoryButton(categoryName: "Dessert", isSelected: true, onTap: {})
        CategoryButton(categoryName: "Dessert", isSelected: false, onTap: {})
    }
}
