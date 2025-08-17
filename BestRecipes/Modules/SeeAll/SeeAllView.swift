//
//  SeeAllView.swift
//  BestRecipes
//
//  Created by Sergey Zakurakin on 8/13/25.
//

import SwiftUI


struct SeeAllView: View {
    @StateObject var viewModel: SeeAllViewModel

    init(type: SeeAllType, items: [RecipeModel]) {
        self._viewModel = StateObject(wrappedValue: SeeAllViewModel(type: type, items: items))
    }
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
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackBarButtonView()
            }
        }
    }
}

#Preview("Trending now") {
    NavigationStack {
        SeeAllView(type: .trendingNow, items: RecipeModel.trendingMock)
    }
}


