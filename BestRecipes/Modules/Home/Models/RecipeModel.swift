
import Foundation

struct RecipeModel: Identifiable, Equatable, Hashable {
    let id: Int
    let title: String
    let image: URL
    let author: String
    let spoonacularScore: Double
    let readyInMinutes: String
}

extension RecipeModel {
    /// Массив моковых рецептов
    static let mockData: [RecipeModel] = [
        RecipeModel(
            id: 1,
            title: "Spaghetti Carbonara",
            image: URL(string: "https://spoonacular.com/recipeImages/716429-312x231.jpg")!,
            author: "Spaghetti Carbonara",
            spoonacularScore: 95.0,
            readyInMinutes: "5 min"
        ),
        RecipeModel(
            id: 2,
            title: "Chicken Parmesan",
            image: URL(string: "https://spoonacular.com/recipeImages/715538-312x231.jpg")!,
            author: "Spaghetti Carbonara",
            spoonacularScore: 90.5,
            readyInMinutes: "5 min"
        ),
        RecipeModel(
            id: 3,
            title: "Beef Stroganoff",
            image: URL(string: "https://spoonacular.com/recipeImages/632660-312x231.jpg")!,
            author: "Spaghetti Carbonara",
            spoonacularScore: 88.0,
            readyInMinutes: "5 min"
        ),
        RecipeModel(
            id: 4,
            title: "Pad Thai",
            image: URL(string: "https://spoonacular.com/recipeImages/664823-312x231.jpg")!,
            author: "Spaghetti Carbonara",
            spoonacularScore: 92.0,
            readyInMinutes: "5 min"
        ),
        RecipeModel(
            id: 5,
            title: "Greek Salad",
            image: URL(string: "https://spoonacular.com/recipeImages/715446-312x231.jpg")!,
            author: "Spaghetti Carbonara",
            spoonacularScore: 85.0,
            readyInMinutes: "5 min"
        )
    ]
    /// Моковые данные для популярных рецептов (trending)
        static var trendingMock: [RecipeModel] {
            Array(mockData.prefix(3))
        }

        /// Моковые данные для популярных категорий
        static var popularCategoryMock: [RecipeModel] {
            Array(mockData.suffix(3))
        }

        /// Моковые данные рецептов по странам (кухня)
        static var cuisineByCountryMock: [RecipeModel] {
            mockData
        }
    }
