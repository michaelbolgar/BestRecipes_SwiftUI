//

import SwiftUI

struct PopularCategoryCell: View {
    // MARK: - Properties
    let recipe: [RecipeModel]
    var showDetail: (Int) -> Void
    
    // MARK: - Body
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                if recipe.isEmpty  {
                    ForEach(1..<6) { plug in
                        ShimmerView(ratio: 1)
                    }
                } else {
                    ForEach(recipe) { recipe in
                        SavedRecipesCell()
                            .padding(.vertical, Offsets.x0)
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
    PopularCategoryCell(recipe: [], showDetail: {_ in })
}
