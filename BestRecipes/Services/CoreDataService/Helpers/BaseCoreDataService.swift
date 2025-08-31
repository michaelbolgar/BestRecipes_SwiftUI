//
//  BaseCoreDataService.swift
//  BestRecipes
//
//  Created by Келлер Дмитрий on 31.08.2025.
//


import CoreData

class BaseCoreDataService: ObservableObject {
    // MARK: - Properties
    let viewContext: NSManagedObjectContext
    
    // MARK: - Init
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
    }
    
    // MARK: - CoreData Helpers
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                print("❌ CoreData save error:", error.localizedDescription)
            }
        }
    }
}