//
//  CoreDataService.swift
//  BestRecipes
//
//  Created by Келлер Дмитрий on 21.08.2025.
//

import CoreData
import SwiftUI
import Combine

final class CoreDataService: ObservableObject {
    // MARK: - Child Services
    let recent: RecentRecipesService
    let created: CreatedRecipesService
    let favorites: FavoriteRecipesService
    
    // MARK: - Published Properties
    @Published var favoriteRecipes: [RecipeModel] = []
    @Published var createdRecipes: [RecipeModel] = []
    @Published var recentRecipes: [RecentEntity] = []
    
    // MARK: - Private
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    init(viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.recent = RecentRecipesService(viewContext: viewContext)
        self.created = CreatedRecipesService(viewContext: viewContext)
        self.favorites = FavoriteRecipesService(viewContext: viewContext)
        
        bindServices()
    }
    
    // MARK: - Bindings
    private func bindServices() {
        recent.$recentRecipes
            .assign(to: \.recentRecipes, on: self)
            .store(in: &cancellables)
        
        created.$createdRecipes
            .assign(to: \.createdRecipes, on: self)
            .store(in: &cancellables)
        
        favorites.$favoriteRecipes
            .assign(to: \.favoriteRecipes, on: self)
            .store(in: &cancellables)
    }
}

// MARK: - Preview
extension CoreDataService {
    static var preview: CoreDataService = {
        let controller = PersistenceController.preview
        return CoreDataService(viewContext: controller.container.viewContext)
    }()
}
