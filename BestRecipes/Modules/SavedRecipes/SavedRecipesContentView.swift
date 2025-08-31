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
                    ForEach(coreDataService.favorites.favoriteRecipes, id: \.self) { recipe in
                        SeeAllCell(
                            recipe: recipe,
                            isFavorited: coreDataService.favorites.isFavorite(recipeID: recipe.id),
                            toggleBookmark:
                                withAnimation(.easeOut(duration: 0.2)) {
                                    {  coreDataService.favorites.toggleFavorite(recipe) }
                                }
                        )
                        .padding(.horizontal)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            navigationPath.append(recipe.id)
                        }
                     
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
