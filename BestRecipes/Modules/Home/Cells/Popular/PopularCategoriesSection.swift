//

import SwiftUI

struct PopularCategoriesSection: View {
    // MARK: - Properties
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
                        PopularCell(recipe: recipe)
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
    PopularCategoriesSection(recipe: RecipeModel.popularCategoryMock, showDetail: {_ in })
}
