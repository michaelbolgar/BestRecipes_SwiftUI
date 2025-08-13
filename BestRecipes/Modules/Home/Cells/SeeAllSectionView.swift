//
//  MainCategorySectionView.swift
//  BestRecipes
//
//  Created by Келлер Дмитрий on 13.08.2025.
//


import SwiftUI

struct SeeAllSectionView: View {
    // MARK: - Properties
    let title: String
    var isShowAll = false
    
    // MARK: - Body
    var body: some View {
        HStack {
            Text(title)
                .recipesMaxTitleStyle()
            
            Spacer()
            if isShowAll {
                HStack(spacing: Offsets.x0 ) {
                    Text("See All")
                        .recipesSeeAllTextStyle()
                        .padding(.trailing, Offsets.x3)
                    AppImages.arrowRight
                }
            }
        }
    }
}

#Preview {
    SeeAllSectionView(title: "Trending now", isShowAll: true)
}
