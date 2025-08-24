//
//  BestRecipesApp.swift
//  BestRecipes
//
//  Created by Михаил Болгар on 11.08.2025.
//

import SwiftUI

@main
struct BestRecipesApp: App {
    @StateObject private var coreDataService: CoreDataService = .init()
    
    init() {
        registerCoreDataStack() 
    }
    
    var body: some Scene {
        WindowGroup {
            StartRouterView()
                .environmentObject(coreDataService)
                .preferredColorScheme(.light)
        }
    }
    
    private func registerCoreDataStack() {
        ValueTransformer.setValueTransformer(
            DictionaryTransformer(),
            forName: NSValueTransformerName("DictionaryTransformer")
        )
    }
}
