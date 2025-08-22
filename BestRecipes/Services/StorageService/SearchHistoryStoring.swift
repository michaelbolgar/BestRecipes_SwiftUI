//
//  SearchHistoryStoring.swift
//  BestRecipes
//
//  Created by Келлер Дмитрий on 19.08.2025.
//


import Foundation

protocol ISearchHistory {
    func loadHistory() -> [String]
    func saveQuery(_ query: String)
    func clearRecentSearches(_ query: String)
}

final class SearchHistoryService: ISearchHistory {
    private let key = "search_history"
    private let maxItems: Int
    
    init(maxItems: Int = 10) {
        self.maxItems = maxItems
    }
    
    func loadHistory() -> [String] {
        UserDefaults.standard.stringArray(forKey: key) ?? []
    }
    
    func saveQuery(_ query: String) {
        guard query.count > 3 else { return }  // сохраняем только длинные
        var history = loadHistory()
        
        // убираем дубликат если он уже есть
        history.removeAll { $0.caseInsensitiveCompare(query) == .orderedSame }
        
        // вставляем в начало
        history.insert(query, at: 0)
        
        // ограничиваем размер
        if history.count > maxItems {
            history = Array(history.prefix(maxItems))
        }
        
        UserDefaults.standard.set(history, forKey: key)
    }
    
    func clearRecentSearches(_ query: String) {
        var history = loadHistory()
        history.removeAll {$0 == query }
        
        UserDefaults.standard.set(history, forKey: key)
    }
}
