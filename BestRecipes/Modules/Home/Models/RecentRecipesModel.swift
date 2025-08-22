import Foundation

protocol RecipesConvertible {
    var id: Int { get }
    var title: String { get }
    var imageString: String { get }
    var author: String { get }
}

struct RecentRecipesModel: RecipesConvertible, Identifiable, Equatable, Hashable {
    let id: Int
    let title: String
    let imageString: String // or image?
    let author: String
}

extension RecentRecipesModel {
    /// Массив моковых рецептов
    static let mockData: [RecentRecipesModel] = [
        RecentRecipesModel(
            id: 1,
            title: "Spaghetti Carbonara",
            imageString:  "https://spoonacular.com/recipeImages/716429-312x231.jpg",
            author: "Gordon Ramsay"
        ),
        RecentRecipesModel(
            id: 2,
            title: "Chicken Parmesan",
            imageString: "https://spoonacular.com/recipeImages/715538-312x231.jpg",
            author: "Gordon Ramsay"
        ),
        RecentRecipesModel(
            id: 3,
            title: "Beef Stroganoff",
            imageString: "https://spoonacular.com/recipeImages/632660-312x231.jpg",
            author: "Gordon Ramsay"
        ),
        RecentRecipesModel(
            id: 4,
            title: "Pad Thai",
            imageString: "https://spoonacular.com/recipeImages/664823-312x231.jpg",
            author: "Gordon Ramsay"
        ),
        RecentRecipesModel(
            id: 5,
            title: "Greek Salad",
            imageString: "https://spoonacular.com/recipeImages/715446-312x231.jpg",
            author: "Gordon Ramsay"
        )
    ]
}
