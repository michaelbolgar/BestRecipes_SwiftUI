//
//  FavoriteRecipesService.swift
//  BestRecipes
//
//  Created by Келлер Дмитрий on 31.08.2025.
//


import CoreData

final class FavoriteRecipesService: BaseCoreDataService {
    // MARK: - Properties
    
    @Published var favoriteRecipes: [RecipeModel] = []
    
    // MARK: - Init
    override init(viewContext: NSManagedObjectContext) {
        super.init(viewContext: viewContext)
        fetchFavoriteRecipes()
    }

    // MARK: - Public Methods
    func fetchFavoriteRecipes() {
        let request = FavoriteEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \FavoriteEntity.dateAdded, ascending: false)]
        let entities = (try? viewContext.fetch(request)) ?? []
        favoriteRecipes = entities.map { RecipeModel(from: $0) }
    }
    
    func saveFavoriteRecipe(_ recipe: RecipeModel) {
        let request: NSFetchRequest<FavoriteEntity> = FavoriteEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", recipe.id)
        
        if let existing = try? viewContext.fetch(request), !existing.isEmpty {
            return
        }
        
        let entity = FavoriteEntity(context: viewContext)
        entity.id = Int64(recipe.id)
        entity.title = recipe.title
        entity.author = recipe.author
        entity.imageString = recipe.image.absoluteString
        entity.readyInMinutes = recipe.readyInMinutes
        entity.spoonacularScore = recipe.spoonacularScore
        entity.dateAdded = Date()
        
        saveContext()
        fetchFavoriteRecipes()
    }
    
    func deleteFavorite(recipeID: Int) {
        let request: NSFetchRequest<FavoriteEntity> = FavoriteEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", recipeID)
        
        if let results = try? viewContext.fetch(request) {
            results.forEach { viewContext.delete($0) }
        }
        saveContext()
        fetchFavoriteRecipes()
    }
    
    func isFavorite(recipeID: Int) -> Bool {
        favoriteRecipes.contains { $0.id == recipeID }
    }
    
    func toggleFavorite(_ recipe: RecipeModel) {
        if isFavorite(recipeID: recipe.id) {
            deleteFavorite(recipeID: recipe.id)
        } else {
            saveFavoriteRecipe(recipe)
        }
    }
}
