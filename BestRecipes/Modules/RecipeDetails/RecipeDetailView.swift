//
//  SeeAllView.swift
//  BestRecipes
//
//  Created by KOZLOVA Anastasia on 14.08.2025.
//

import SwiftUI

struct RecipeDetailView: View {
    @ObservedObject var viewModel: SeeAllViewModel

    var body: some View {
        List {
            ForEach(viewModel.items) { item in
                RecipeListRow(recipe: item)
                    .listRowSeparator(.hidden)
                    .listRowInsets(.init(top: 8, leading: 0, bottom: 16, trailing: 0))
            }
        }
        .listStyle(.plain)
        .padding(.horizontal, Offsets.x4)
        .navigationTitle(viewModel.type.title)
        .background(Color.appBackground.ignoresSafeArea())
    }
}

#Preview("Trending now") {
    NavigationStack {
        SeeAllView(viewModel: SeeAllViewModel(type: .trendingNow))
    }
}
