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
    
    @Published var resentRecipes: [RecentEntity] = []
    
    init(viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.viewContext = viewContext
        fetchEvents()
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
        let recentEntity = RecentEntity(context: viewContext)
        recentEntity.id = Int64(recipe.id)
        recentEntity.title = recipe.title
        recentEntity.imageURL = recipe.imageString
        recentEntity.author = recipe.author
        saveContext()
        fetchEvents()
    }
    
    func fetchEvents() {
        let request = RecentEntity.fetchRequest()
        let sortDescription = NSSortDescriptor(keyPath: \RecentEntity.id, ascending: true)
        request.sortDescriptors = [sortDescription]
        
        do {
            resentRecipes = try viewContext.fetch(request)
        } catch {
            let nserror = error as NSError
            print("Не удалось получить события: \(nserror), \(nserror.userInfo)")
        }
    }
    
    func deleteRecipe(_ recipe: RecentEntity) {
        viewContext.delete(recipe)
        saveContext()
        fetchEvents()
    }
    
    func deleteRecipe(id: Int) {
        let fetchRequest: NSFetchRequest<RecentEntity> = RecentEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        do {
            let recentRecipe = try viewContext.fetch(fetchRequest)
            for recipe in recentRecipe {
                viewContext.delete(recipe)
            }
            saveContext()
            fetchEvents()
        } catch {
            let nserror = error as NSError
            print("Ошибка при удалении события: \(nserror), \(nserror.userInfo)")
        }
    }
}

