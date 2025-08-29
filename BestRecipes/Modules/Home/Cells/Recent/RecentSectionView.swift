//
//  RecentSectionView.swift
//  BestRecipes
//
//  Created by Келлер Дмитрий on 21.08.2025.
//

import SwiftUI

struct RecentSectionView: View {
    // MARK: - Properties
    let recipe: [RecentRecipesModel]
    var showDetail: (Int) -> Void
    
    @State private var appearedIndexes: Set<Int> = []
    
    // MARK: - Body
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(Array(recipe.enumerated()), id: \.element.id) { index, recipe in
                    RecentRecipesCell(recipe: recipe)
                        .padding(.vertical, Offsets.x2)
                        .opacity(appearedIndexes.contains(index) ? 1 : 0)
                        .scaleEffect(appearedIndexes.contains(index) ? 1 : 0.95)
                        .animation(.easeOut(duration: 0.6).delay(Double(index) * 0.1), value: appearedIndexes)
                        .onAppear {
                            appearedIndexes.insert(index)
                        }
                        .onTapGesture {
                            showDetail(recipe.id)
                        }
                }
            }
        }
        .padding(.horizontal, Offsets.x2)
    }
}

#Preview {
    HomeContentView()
        .environmentObject(CoreDataService())
}
