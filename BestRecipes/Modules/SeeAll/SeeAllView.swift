//
//  SeeAllView.swift
//  BestRecipes
//
//  Created by Sergey Zakurakin on 8/13/25.
//

import SwiftUI

struct SeeAllView: View {
    let type: SeeAllExploreType
    let items: [RecipeModel]

    var body: some View {
        List {
            ForEach(items) { item in
                RecipeListRow(recipe: item)
                    .listRowSeparator(.hidden)
                    .listRowInsets(.init(top: 8, leading: 0, bottom: 16, trailing: 0))
            }
        }
        .listStyle(.plain)
        .padding(.horizontal, Offsets.x4)
        .navigationTitle(type.title)
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.appBackground.ignoresSafeArea())
    }
}

#Preview("Trending now") {
    NavigationStack {
        SeeAllView(type: .trendingNow, items: RecipeModel.trendingMock)
    }
}



