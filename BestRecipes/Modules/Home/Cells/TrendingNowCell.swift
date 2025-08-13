
import SwiftUI

struct TrendingNowCell: View {

    let recipe: [RecipeModel]
    var showDetail: (Int) -> Void
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                if recipe.isEmpty  {
                    ForEach(1..<6) { plug in
                        ShimmerView(ratio: 1)
                    }
                } else {
                    ForEach(recipe) { event in
                        SavedRecipesCell()
                            .padding(.vertical, 10)
                            .onTapGesture {
                                showDetail(event.id)
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
