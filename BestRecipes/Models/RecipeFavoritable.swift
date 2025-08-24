import Foundation

/// модель-обёртка для отслеживания, добавлен ли рецепт в избранное
struct RecipeFavoritable: Identifiable, Equatable, Hashable {
    let recipeDetails: RecipeModel

    var isFavorited: Bool = false
    var id: Int { recipeDetails.id }
    var imageURL: URL { recipeDetails.image }
}
