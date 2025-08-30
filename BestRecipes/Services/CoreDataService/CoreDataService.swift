//
//  CoreDataService.swift
//  BestRecipes
//
//  Created by Келлер Дмитрий on 21.08.2025.
//

import CoreData
import SwiftUI

final class CoreDataService: ObservableObject {
    // MARK: - Properties
    let viewContext: NSManagedObjectContext
    
    @Published var recentRecipes: [RecentEntity] = []
    @Published var createdRecipes: [RecipeModel] = []
    
    @Published var favoriteRecipes: [RecipeModel] = []
    
    //    MARK: - INIT
    init(viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.viewContext = viewContext
        
        fetchResipes()
        fetchCreatedRecipes()
        fetchFavoriteRecipes()
    }
    
    //    MARK: - Save Context
    private func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    //    MARK: - Recent Recipe
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
    
    //    MARK: - Created Recipes
    func createCreatedRecipe(title: String, serves: String, cookTime: String, ingredients: [String:String], imageData: Data? = nil) {
        let recipe = CreatedRecipeEntity(context: viewContext)
        recipe.title = title
        recipe.serves = Int16(serves.hashValue)
        recipe.cookTime = cookTime
        recipe.ingredients = ingredients as NSObject
        recipe.imageData = imageData
        recipe.dateAdded = Date()
        
        saveContext()
        fetchCreatedRecipes()
    }
    
    func fetchCreatedRecipes() {
        let request = CreatedRecipeEntity.fetchRequest()
        do {
            let entities = try viewContext.fetch(request)
            
            let createdModels = entities.map { CreatedRecipeModel(entity: $0) }
            
            self.createdRecipes = createdModels.map {  RecipeModel(from: $0 )
            }
        } catch {
            print("Fetch created recipes error: \(error)")
        }
    }
}

//    MARK: - extension Favorite Recipes
extension CoreDataService {
    func fetchFavoriteRecipes() {
        let request = FavoriteEntity.fetchRequest()
        let sortDescription = NSSortDescriptor(keyPath: \FavoriteEntity.id, ascending: true)
        request.sortDescriptors = [sortDescription]
        
        do {
            let entities = try viewContext.fetch(request)
            
            favoriteRecipes = entities.map { RecipeModel(from: $0)}
        } catch {
            let nserror = error as NSError
            print("Не удалось получить рецепты: \(nserror), \(nserror.userInfo)")
        }
    }
    
    func saveFavoriteRecipes(_ favoriteRecipe: RecipeModel) {
        let fetchRequest: NSFetchRequest<FavoriteEntity> = FavoriteEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", favoriteRecipe.id)

        if let existing = try? viewContext.fetch(fetchRequest), !existing.isEmpty {
            return // уже есть в избранном, не добавляем ещё раз
        }
        
        let favorite = FavoriteEntity(context: viewContext)
        favorite.id = Int64(favoriteRecipe.id)
        favorite.title = favoriteRecipe.title
        favorite.author = favoriteRecipe.author
        favorite.imageString = favoriteRecipe.image.absoluteString
        favorite.dateAdded = Date()
        
        saveContext()
        fetchFavoriteRecipes()
    }
    
    func deleteFavorite(recipeID: Int) {
        let fetchRequest: NSFetchRequest<FavoriteEntity> = FavoriteEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", recipeID)
        do {
            let favoriteToDelete = try viewContext.fetch(fetchRequest)
            for favoriteRecipe in favoriteToDelete {
                viewContext.delete(favoriteRecipe)
            }
            saveContext()
            fetchFavoriteRecipes()
        } catch {
            let nserror = error as NSError
            print("Ошибка при удалении события: \(nserror), \(nserror.userInfo)")
        }
    }
    
    func isFavorite(recipeID: Int) -> Bool {
        favoriteRecipes.contains { $0.id == recipeID }
    }
    
    func toggleFavorite(_ recipe: RecipeModel) {
        if isFavorite(recipeID: recipe.id) {
            deleteFavorite(recipeID: recipe.id)
            print(" удалили \(recipe.id)")
        } else {
            saveFavoriteRecipes(recipe)
            print(" добавили \(recipe.id)")
        }
    }
}
