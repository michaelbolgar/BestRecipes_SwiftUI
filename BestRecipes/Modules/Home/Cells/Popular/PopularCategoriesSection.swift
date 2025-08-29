//

import SwiftUI

struct PopularCategoriesSection: View {
    // MARK: - Properties
    @EnvironmentObject private var coreDataService: CoreDataService
    
    let recipe: [RecipeModel]
    var showDetail: (Int) -> Void

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
                        PopularCell(
                            recipe: recipe,
                            isFavorited: coreDataService.isFavorite(recipeID: recipe.id),
                            toggleBookmark: { coreDataService.toggleFavorite(recipe)}
                        )
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
    PopularCategoriesSection(recipe: RecipeModel.trendingMockBookable, showDetail: {_ in })
}
