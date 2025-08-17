import Foundation

struct RecentRecipesModel: Identifiable, Equatable, Hashable {
    let id: Int
    let title: String
    let image: URL
    let author: String
}

extension RecentRecipesModel {
    /// Массив моковых рецептов
    static let mockData: [RecentRecipesModel] = [
        RecentRecipesModel(
            id: 1,
            title: "Spaghetti Carbonara",
            image: URL(string: "https://spoonacular.com/recipeImages/716429-312x231.jpg")!,
            author: "Gordon Ramsay"
        ),
        RecentRecipesModel(
            id: 2,
            title: "Chicken Parmesan",
            image: URL(string: "https://spoonacular.com/recipeImages/715538-312x231.jpg")!,
            author: "Gordon Ramsay"
        ),
        RecentRecipesModel(
            id: 3,
            title: "Beef Stroganoff",
            image: URL(string: "https://spoonacular.com/recipeImages/632660-312x231.jpg")!,
            author: "Gordon Ramsay"
        ),
        RecentRecipesModel(
            id: 4,
            title: "Pad Thai",
            image: URL(string: "https://spoonacular.com/recipeImages/664823-312x231.jpg")!,
            author: "Gordon Ramsay"
        ),
        RecentRecipesModel(
            id: 5,
            title: "Greek Salad",
            image: URL(string: "https://spoonacular.com/recipeImages/715446-312x231.jpg")!,
            author: "Gordon Ramsay"
        )
    ]
}
