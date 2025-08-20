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
        ScrollView(.vertical, showsIndicators: true) {
            VStack {
                ForEach(viewModel.items) { item in
                    NavigationLink {
                        RecipeDetailView(recipeID: item.id)
                    } label: {
                        RecipeListRow(recipe: item)
                            .padding(.vertical, Offsets.x2)
                    }
                }
            }
        }
        .background(Color.appBackground.ignoresSafeArea())
        .padding(.vertical, Offsets.x4)
        .padding(.horizontal, Offsets.x4)
        .navigationTitle(viewModel.type.title)
        
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


