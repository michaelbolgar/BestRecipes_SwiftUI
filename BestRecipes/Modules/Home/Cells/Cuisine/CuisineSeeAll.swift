//
//  CuisineSeeAll.swift
//  BestRecipes
//
//  Created by Келлер Дмитрий on 17.08.2025.
//

import SwiftUI

struct CuisineSeeAll: View {
    // MARK: - Properties
    let сuisine: [Cuisine]
    
    var body: some View {
        List {
            ForEach(сuisine) { item in
                СuisineByCountryCell(
                    image: item.imageName,
                    title: item.displayName
                )
                    .listRowSeparator(.hidden)
                    .listRowInsets(.init(top: 8, leading: 0, bottom: 16, trailing: 0))
            }
        }
        .listStyle(.plain)
        .padding(.horizontal, Offsets.x4)
        .navigationTitle("Popular cuisines")
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

#Preview {
    CuisineSeeAll(сuisine: [])
}
