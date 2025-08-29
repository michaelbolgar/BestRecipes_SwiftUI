import SwiftUI

struct SavedRecipesContentView: View {
    // MARK: - Properties
    @EnvironmentObject private var coreDataService: CoreDataService
    
    @StateObject private var viewModel = SavedRecipesViewModel()
    @State private var navigationPath = NavigationPath()
    
    // MARK: - Body
    var body: some View {
        NavigationStack(path: $navigationPath) {
            ScrollView {
                LazyVStack(spacing: Offsets.x3) {
                    ForEach(coreDataService.favoriteRecipes, id: \.self) { recipe in
                        SavedRecipesCell(
                            recipe: recipe,
                            isFavorited: coreDataService.isFavorite(recipeID: recipe.id),
                            toggleBookmark:
                                withAnimation(.easeOut(duration: 0.2)) {
                                    {  coreDataService.toggleFavorite(recipe) }
                                }
                        )
                        .contentShape(Rectangle())
                        .onTapGesture {
                            navigationPath.append(recipe.id)
                        }
                        .frame(maxWidth: .infinity)
                        .transition( .opacity)
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

#Preview {
    SavedRecipesContentView()
        .environmentObject(CoreDataService())
}
