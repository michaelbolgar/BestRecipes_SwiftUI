//

import SwiftUI

struct PopularCategoriesSection: View {
    // MARK: - Properties
    let recipe: [RecipeFavoritable]
    var showDetail: (Int) -> Void
    let toggleBookmark: (Int) -> Void

    // MARK: - Body
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                if recipe.isEmpty  {
                    ForEach(1..<6) { plug in
                        ShimmerForPopular()
                    }
                } else {
                    ForEach(recipe) { recipe in
                        PopularCell(recipe: recipe, toggleBookmark: { toggleBookmark(recipe.id) })
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
    PopularCategoriesSection(recipe: RecipeFavoritable.trendingMockBookable, showDetail: {_ in }, toggleBookmark: {_ in })
}
