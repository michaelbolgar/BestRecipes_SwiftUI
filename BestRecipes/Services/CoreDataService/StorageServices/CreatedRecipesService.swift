//
//  CreatedRecipesService.swift
//  BestRecipes
//
//  Created by Келлер Дмитрий on 31.08.2025.
//


import CoreData

final class CreatedRecipesService: BaseCoreDataService {
    // MARK: - Properties
    @Published var createdRecipes: [RecipeModel] = []
    
    // MARK: - Init
    override init(viewContext: NSManagedObjectContext) {
        super.init(viewContext: viewContext)
        fetchCreatedRecipes()
    }

    // MARK: - Public Methods
    func createCreatedRecipe(
        title: String,
        serves: String,
        cookTime: String,
        ingredients: [String:String],
        imageData: Data? = nil
    ) {
        let recipe = CreatedRecipeEntity(context: viewContext)
        recipe.title = title
        recipe.serves = Int16(serves) ?? 0
        recipe.cookTime = cookTime
        recipe.ingredients = ingredients as NSObject
        recipe.imageData = imageData
        recipe.dateAdded = Date()
        
        saveContext()
        fetchCreatedRecipes()
    }
    
    func fetchCreatedRecipes() {
        let request = CreatedRecipeEntity.fetchRequest()
        let entities = (try? viewContext.fetch(request)) ?? []
        
        let models = entities.map { CreatedRecipeModel(entity: $0) }
        self.createdRecipes = models.map { RecipeModel(from: $0) }
    }
}
