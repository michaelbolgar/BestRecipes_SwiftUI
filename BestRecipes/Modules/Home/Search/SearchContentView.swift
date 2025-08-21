//
//  SearchContentView.swift
//  BestRecipes
//
//  Created by Келлер Дмитрий on 19.08.2025.
//

import SwiftUI

struct SearchContentView: View {
    // MARK: - Properties
    @ObservedObject var viewModel: HomeViewModel
    var onSelectRecipe: (Int) -> Void
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: Offsets.x2) {
            if !viewModel.searchText.isEmpty {
                // --- РЕЗУЛЬТАТЫ ПОИСКА ---
                if viewModel.searchResults.isEmpty {
                    Text("No results found")
                        .recipesNavTitleStyle()
                } else {
                    ScrollView {
                        searchResultView()
                            .padding(.top, Offsets.x2)
                            .transition(.opacity)
                            .animation(.easeInOut, value: viewModel.searchResults)
                    }
                }
            } else {
                // --- ПОДСКАЗКИ ---
                ScrollView {
                    recentSearchesView()
                }
            }
        }
        .padding(.horizontal, Offsets.x2)
    }
}

extension SearchContentView {
    //    MARK: - VIEWS
    func searchResultView() -> some View {
        LazyVStack(alignment: .leading, spacing: Offsets.x4) {
            ForEach(viewModel.searchResults) { recipe in
                SearchRecipeCell(recipe: recipe)
                    .onTapGesture {
                        onSelectRecipe(recipe.id)
                    }
            }
        }
    }
    
    func recentSearchesView() -> some View {
        VStack(alignment: .leading, spacing: Offsets.x3) {
            if !viewModel.recentSearches.isEmpty {
                Text("Recent Searches")
                    .font(.headline)
                    .foregroundStyle(.secondary)
                    .padding(.top, Offsets.x2)
                
                ForEach(viewModel.recentSearches.reversed(), id: \.self) { item in
                    HStack {
                        Button {
                            withAnimation {
                                viewModel.searchText = item
                            }
                        } label: {
                            Text(item)
                                .recipesTitleStyle()
                                .padding(.vertical, Offsets.x2)
                        }
                        Spacer()
                        Button {
                            withAnimation {
                                viewModel.clearRecentSearches(item)
                            }
                        } label: {
                            Image(systemName: "trash")
                                .foregroundStyle(.red)
                        }
                        Divider()
                    }
                }
            }
        }
    }
}

#Preview {
    SearchContentView(viewModel: HomeViewModel(), onSelectRecipe: {_ in})
}
