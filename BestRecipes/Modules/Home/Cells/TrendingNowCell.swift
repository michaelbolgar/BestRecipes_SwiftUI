
import SwiftUI

struct TrendingNowCell: View {
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
    TrendingNowCell(recipe: [], showDetail: {_ in })
}
