//
//  PersistenceController.swift
//  BestRecipes
//
//  Created by Келлер Дмитрий on 22.08.2025.
//


import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    // Для превью и SwiftUI Canvas
    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        let viewContext = controller.container.viewContext
        
        // Создадим несколько тестовых рецептов
        for i in 0..<3 {
            let recipe = CreatedRecipeEntity(context: viewContext)
            recipe.id = UUID()
            recipe.title = "Mock Recipe \(i + 1)"
            recipe.serves = Int16(2 + i)
            recipe.cookTime = Int16(10 * (i + 1))
            recipe.ingredients = ["Ingredient \(i+1)": "\(i*100) g"] as NSObject
        }
        
        do {
            try viewContext.save()
        } catch {
            fatalError("Ошибка сохранения моков: \(error.localizedDescription)")
        }
        
        return controller
    }()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "RecipesStorage")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Не удалось загрузить хранилище Core Data: \(error), \(error.userInfo)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
