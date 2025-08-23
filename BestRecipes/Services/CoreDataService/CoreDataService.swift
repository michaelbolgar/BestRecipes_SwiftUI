//
//  CoreDataService.swift
//  BestRecipes
//
//  Created by Келлер Дмитрий on 21.08.2025.
//

import CoreData
import SwiftUI

final class CoreDataService: ObservableObject {
    let viewContext: NSManagedObjectContext
    
    @Published var recentRecipes: [RecentEntity] = []
    
    init(viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.viewContext = viewContext
        fetchResipes()
    }
    
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func createRecentRecipe<T: RecipesConvertible>(recipe: T) {
        
        let request = RecentEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", recipe.id)
        if let existing = try? viewContext.fetch(request).first {
            viewContext.delete(existing)
        }
        
        let recentEntity = RecentEntity(context: viewContext)
        recentEntity.id = Int64(recipe.id)
        recentEntity.title = recipe.title
        recentEntity.imageString = recipe.imageString
        recentEntity.author = recipe.author
        recentEntity.dateAdded = Date()
        
        saveContext()
        fetchResipes()
        
        if recentRecipes.count > 10 {
            let extra = recentRecipes.dropLast(10)
            extra.forEach { viewContext.delete($0)}
            saveContext()
            fetchResipes()
        }
    }
    
    func fetchResipes() {
        let request = RecentEntity.fetchRequest()
        let sortDescription = NSSortDescriptor(keyPath: \RecentEntity.id, ascending: true)
        request.sortDescriptors = [sortDescription]
        
        do {
            recentRecipes = try viewContext.fetch(request)
        } catch {
            let nserror = error as NSError
            print("Не удалось получить рецепты: \(nserror), \(nserror.userInfo)")
        }
    }
}

