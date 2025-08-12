//
//  SearchRecipeCell.swift
//  BestRecipes
//
//  Created by Келлер Дмитрий on 13.08.2025.
//

import SwiftUI

struct SearchRecipeCell: View {
   @Binding var searchText: String
    enum Drawing {
        static let placeholderText = "search"
    }
    var body: some View {
        TextField("", text: $searchText)
            .placeholder(when: searchText.isEmpty) {
                Text(Drawing.placeholderText)
            }
        
    }
}

#Preview {
    SearchRecipeCell(searchText: .constant("search"))
}
