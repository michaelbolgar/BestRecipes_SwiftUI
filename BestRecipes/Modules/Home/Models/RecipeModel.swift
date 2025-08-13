
import Foundation

struct RecipeModel: Identifiable {
    let id: Int
    let title: String
    let image: URL
    let spoonacularScore: Double
}

extension RecipeModel {
    /// Массив моковых рецептов
    static let mockData: [RecipeModel] = [
        RecipeModel(
            id: 1,
            title: "Spaghetti Carbonara",
            image: URL(string: "https://spoonacular.com/recipeImages/716429-312x231.jpg")!,
            spoonacularScore: 95.0
        ),
        RecipeModel(
            id: 2,
            title: "Chicken Parmesan",
            image: URL(string: "https://spoonacular.com/recipeImages/715538-312x231.jpg")!,
            spoonacularScore: 90.5
        ),
        RecipeModel(
            id: 3,
            title: "Beef Stroganoff",
            image: URL(string: "https://spoonacular.com/recipeImages/632660-312x231.jpg")!,
            spoonacularScore: 88.0
        ),
        RecipeModel(
            id: 4,
            title: "Pad Thai",
            image: URL(string: "https://spoonacular.com/recipeImages/664823-312x231.jpg")!,
            spoonacularScore: 92.0
        ),
        RecipeModel(
            id: 5,
            title: "Greek Salad",
            image: URL(string: "https://spoonacular.com/recipeImages/715446-312x231.jpg")!,
            spoonacularScore: 85.0
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
