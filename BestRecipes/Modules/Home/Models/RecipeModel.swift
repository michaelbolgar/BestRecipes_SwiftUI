
import SwiftUI

struct RecipeModel: Identifiable, Equatable, Hashable {
    let id: Int
    let title: String
    let image: URL
    let author: String
    let spoonacularScore: Double
    let readyInMinutes: String
    var ingredients: [String : String]? = nil
}

extension RecipeModel {
    init(from recent: RecentRecipesModel) {
        self.id = recent.id
        self.title = recent.title
        self.image = URL(string: recent.imageString) ?? URL(string: "https://via.placeholder.com/300")!
        self.author = recent.author
        self.spoonacularScore = 0
        self.readyInMinutes = ""
    }
}

extension RecipeModel {
    init(from created: CreatedRecipeModel) {
        self.id = created.id.hashValue  
        self.title = created.title
        self.author = "You"
        self.spoonacularScore = 0
        self.readyInMinutes = "\(created.cookTime) min"
        
        if let data = created.imageData,
           let uiImage = UIImage(data: data) {
            // если картинка локальная → кладём во временный файл и получаем URL
            let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent("\(UUID().uuidString).png")
            try? data.write(to: tempURL)
            self.image = tempURL
        } else {
            self.image = URL(string: "https://via.placeholder.com/300")!
        }
        self.ingredients = created.ingredients
    }
}

extension RecipeFavoritable {
    static let mockDataFavoritable: [RecipeFavoritable] = [
        RecipeFavoritable(recipeDetails: RecipeModel(
            id: 1,
            title: "Spaghetti Carbonara",
            image: URL(string: "https://spoonacular.com/recipeImages/716429-312x231.jpg")!,
            author: "Spaghetti Carbonara",
            spoonacularScore: 95.0,
            readyInMinutes: "5 min")
        ),

        RecipeFavoritable(recipeDetails: RecipeModel(
            id: 2,
            title: "Chicken Parmesan",
            image: URL(string: "https://spoonacular.com/recipeImages/715538-312x231.jpg")!,
            author: "Spaghetti Carbonara",
            spoonacularScore: 90.5,
            readyInMinutes: "5 min"
        ),
                          isFavorited: false),

        RecipeFavoritable(recipeDetails: RecipeModel(
            id: 3,
            title: "Beef Stroganoff",
            image: URL(string: "https://spoonacular.com/recipeImages/632660-312x231.jpg")!,
            author: "Spaghetti Carbonara",
            spoonacularScore: 88.0,
            readyInMinutes: "5 min"
        ),
                          isFavorited: false),

        RecipeFavoritable(recipeDetails: RecipeModel(
            id: 4,
            title: "Pad Thai",
            image: URL(string: "https://spoonacular.com/recipeImages/664823-312x231.jpg")!,
            author: "Spaghetti Carbonara",
            spoonacularScore: 92.0,
            readyInMinutes: "5 min"
        ),
                          isFavorited: false),

        RecipeFavoritable(recipeDetails: RecipeModel(
            id: 5,
            title: "Greek Salad",
            image: URL(string: "https://spoonacular.com/recipeImages/715446-312x231.jpg")!,
            author: "Spaghetti Carbonara",
            spoonacularScore: 85.0,
            readyInMinutes: "5 min"
        ),
                          isFavorited: false)
    ]

    /// Моковые данные для популярных рецептов (trending)
    static var trendingMockBookable: [RecipeFavoritable] {
        Array(mockDataFavoritable.prefix(3))
    }

    /// Моковые данные для популярных категорий
    static var popularCategoryMock: [RecipeFavoritable] {
        Array(mockDataFavoritable.suffix(3))
    }

    /// Моковые данные рецептов по странам (кухня)
    static var cuisineByCountryMock: [RecipeFavoritable] {
        Array(mockDataFavoritable.suffix(3))
    }
}
