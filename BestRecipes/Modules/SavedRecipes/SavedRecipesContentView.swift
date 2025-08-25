import SwiftUI

struct SavedRecipesContentView: View {
    @StateObject private var viewModel = SavedRecipesViewModel()

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.savedRecipes) { recipe in
                    SavedRecipesCell(
                        recipe: recipe,
                        toggleBookmark: {
                            viewModel.toggleFavorite(for: recipe.id)
                        }
                    )
                }
            }
            .listStyle(.plain)
            .navigationTitle("Saved recipes")
        }
    }
}



#Preview {
    SavedRecipesContentView()
}
