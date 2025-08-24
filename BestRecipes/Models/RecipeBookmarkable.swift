import Foundation

/// модель-обёртка для отслеживания, добавлен ли рецепт в избранное
struct RecipeBookable: Identifiable, Equatable, Hashable {
    let recipe: RecipeModel
    var isBookmarked: Bool = false

    var id: Int { recipe.id }
    var title: String { recipe.title }
    var imageURL: URL { recipe.image }
}
