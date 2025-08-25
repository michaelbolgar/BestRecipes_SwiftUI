import SwiftUI

struct SavedRecipesContentView: View {
    @StateObject private var viewModel = SavedRecipesViewModel()
    @State private var navigationPath = NavigationPath()

    var body: some View {
        NavigationStack {
            List(viewModel.savedRecipes) { recipe in
                NavigationLink(destination: RecipeDetailView(recipeID: recipe.id)) {
                    SavedRecipesCell(
                        recipe: recipe,
                        toggleBookmark: {
                            viewModel.toggleFavorite(for: recipe.id)
                        }
                    )
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .navigationTitle("Saved recipes")
        }
    }
}



#Preview {
    SavedRecipesContentView()
}
