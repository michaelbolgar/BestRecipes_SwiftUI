//
//  SearchRecipeCell.swift
//  BestRecipes
//
//  Created by Келлер Дмитрий on 13.08.2025.
//

import SwiftUI

struct SearchRecipeCell: View {
    // MARK: - Properties
   @Binding var searchText: String
    
    enum Drawing {
        static let placeholderText = "Search recipes"
    }
    
    // MARK: - Body
    var body: some View {
        HStack(spacing: Offsets.x0) {
            AppImages.search
                .frame(width: Offsets.x5, height: Offsets.x5)
                .foregroundStyle(.neutral90)
                .padding(Offsets.x4)
            
            TextField(Drawing.placeholderText, text: $searchText)

            
            if !searchText.isEmpty {
                Button {
                    searchText = ""
                } label: {
                    AppImages.xmark
                        .foregroundStyle(.neutral20)
                        .padding(Offsets.x4)
                }
                
            }
        }
        .background(Color.appBackground)
        .overlay {
            RoundedRectangle(cornerRadius: Offsets.x3)
                .stroke(.neutral30, lineWidth: 1)
        }
    }
}

#Preview {
    SearchRecipeCell(searchText: .constant("search"))
}
