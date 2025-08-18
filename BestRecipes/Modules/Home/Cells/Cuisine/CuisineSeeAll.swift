//
//  CuisineSeeAll.swift
//  BestRecipes
//
//  Created by Келлер Дмитрий on 17.08.2025.
//

import SwiftUI

struct CuisineSeeAll: View {
    // MARK: - Properties
    let cuisine: [Cuisine]
    var showSeeAll: (Cuisine) -> Void
    
    // Две колонки
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(cuisine) { item in
                    СuisineByCountryCell(
                        image: item.imageName,
                        title: item.displayName
                    )
                    .onTapGesture {
                        showSeeAll(item)
                    }
                }
            }
            .padding(.horizontal, Offsets.x4)
            .padding(.top, Offsets.x4)
        }
        .background(Color.appBackground.ignoresSafeArea())
        .navigationTitle("Popular cuisines")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackBarButtonView()
            }
        }
    }
}

#Preview {
    CuisineSeeAll(cuisine: [], showSeeAll: {_ in})
}
