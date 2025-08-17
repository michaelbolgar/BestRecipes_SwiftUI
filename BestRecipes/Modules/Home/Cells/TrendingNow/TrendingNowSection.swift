
import SwiftUI

struct TrendingNowSection: View {
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
                        TrendingNowCell(recipe: recipe)
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
    TrendingNowSection(recipe: [], showDetail: {_ in })
}
