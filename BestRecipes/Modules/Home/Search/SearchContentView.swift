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
                        .foregroundStyle(.secondary)
                        .padding(.top, Offsets.x4)
                    Spacer()
                } else {
                    ScrollView {
                        searchResultView()
                            .padding(.top, Offsets.x2)
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
        LazyVStack(alignment: .leading, spacing: Offsets.x3) {
            ForEach(viewModel.searchResults) { recipe in
                TrendingNowCell(recipe: recipe)
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
                    Button {
                        viewModel.searchText = item
                    } label: {
                        Text(item)
                            .foregroundStyle(.primary)
                            .padding(.vertical, Offsets.x2)
                    }
                    Divider()
                }
            }
        }
    }
    
}
#Preview {
    SearchContentView(viewModel: HomeViewModel(), onSelectRecipe: {_ in})
}
