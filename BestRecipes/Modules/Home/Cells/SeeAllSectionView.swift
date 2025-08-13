//
//  MainCategorySectionView.swift
//  BestRecipes
//
//  Created by Келлер Дмитрий on 13.08.2025.
//


import SwiftUI

struct SeeAllSectionView: View {
    
    let title: String
    var isShowAll = false
    
    var body: some View {
        HStack {
            Text(title)
                .recipesTitleStyle()
                .frame(width: 200, height: 24, alignment: .leading)
            
            Spacer()
            if isShowAll {
                HStack(spacing: Offsets.x0 ) {
                    Text("See All")
                        .recipesSeeAllTextStyle()
                        .padding(.trailing, 14)
                    AppImages.arrowRight
                }
            }
        }
        .padding(.leading, 24)
    }
}

#Preview {
    SeeAllSectionView(title: "Trending now", isShowAll: true)
}
