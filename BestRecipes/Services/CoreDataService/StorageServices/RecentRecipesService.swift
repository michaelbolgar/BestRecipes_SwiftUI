//
//  RecentRecipesService.swift
//  BestRecipes
//
//  Created by Келлер Дмитрий on 31.08.2025.
//


import CoreData
import Combine

final class RecentRecipesService: BaseCoreDataService {
    // MARK: - Properties
    @Published var recentRecipes: [RecentEntity] = []
    
    // MARK: - Init
    override init(viewContext: NSManagedObjectContext) {
        super.init(viewContext: viewContext)
        fetchRecipes()
    }
    
    // MARK: - Public Methods
    func createRecentRecipe<T: RecipesConvertible>(recipe: T) {
        let request = RecentEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", recipe.id)
        
        if let existing = try? viewContext.fetch(request).first {
            viewContext.delete(existing)
        }
        
        let entity = RecentEntity(context: viewContext)
        entity.id = Int64(recipe.id)
        entity.title = recipe.title
        entity.imageString = recipe.imageString
        entity.author = recipe.author
        entity.dateAdded = Date()
        
        saveContext()
        fetchRecipes()
        
        if recentRecipes.count > 10 {
            let extra = recentRecipes.dropLast(10)
            extra.forEach { viewContext.delete($0) }
            saveContext()
            fetchRecipes()
        }
    }
    
    func fetchRecipes() {
        let request = RecentEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \RecentEntity.dateAdded, ascending: false)]
        recentRecipes = (try? viewContext.fetch(request)) ?? []
    }
}
