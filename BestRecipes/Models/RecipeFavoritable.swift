import Foundation

/// модель-обёртка для отслеживания, добавлен ли рецепт в избранное
struct RecipeFavoritable: Identifiable, Equatable, Hashable {
    let recipeDetails: RecipeModel

    var isFavorited: Bool = false
    var id: Int { recipeDetails.id }
    var title: String { recipeDetails.title }
    var imageURL: URL { recipeDetails.image }
    var readyInMinutes: String { recipeDetails.readyInMinutes }
    var author: String { recipeDetails.author }
}
