import SwiftUI

struct SavedRecipesContentView: View {
    @StateObject private var viewModel = SavedRecipesViewModel()
    @State private var navigationPath = NavigationPath()

    var body: some View {
        NavigationStack(path: $navigationPath) {
            ScrollView {
                VStack(spacing: Offsets.x3) {
                    ForEach(viewModel.savedRecipes) { recipe in
                        SavedRecipesCell(
                            recipe: recipe,
                            toggleBookmark: {
                                viewModel.toggleFavorite(for: recipe.id)
                            }
                        )
                        .contentShape(Rectangle())
                        .onTapGesture {
                            navigationPath.append(recipe.id)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            .navigationTitle("Saved recipes")
            .navigationDestination(for: Int.self) { recipeID in
                RecipeDetailView(recipeID: recipeID)
            }
        }
    }
}
//                .buttonStyle(.plain)
//                .listRowInsets(EdgeInsets())
//                .listRowSeparator(.hidden)
//            }
//            .listStyle(.plain)
//            .navigationTitle("Saved recipes")



#Preview {
    SavedRecipesContentView()
}
