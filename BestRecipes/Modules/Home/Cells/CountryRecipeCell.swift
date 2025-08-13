

import SwiftUI

struct CountryRecipeCell: View {
    // MARK: - Properties
    let recipe: [RecipeModel]
    var showDetail: (Int) -> Void
    
    enum Drawing {
        static let roundSize: CGFloat = 130
    }
    
    // MARK: - Body
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            if recipe.isEmpty  {
                HStack(spacing: Offsets.x4) {
                    ForEach(1..<6) { _ in
                        ShimmerCircle(size: Drawing.roundSize)
                    }
                }
            } else {
                HStack {
                    ForEach(recipe) { recipe in
                        ContryRoundCell(
                            image: recipe.image,
                            title: recipe.title
                        )
                        .padding(.vertical, Offsets.x2)
                        .onTapGesture {
                            showDetail(recipe.id)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    CountryRecipeCell(recipe: [], showDetail: {_ in})
}
