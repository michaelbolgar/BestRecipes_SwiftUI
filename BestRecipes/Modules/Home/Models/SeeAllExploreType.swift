

// MARK: - EventType
enum SeeAllExploreType: Hashable, CaseIterable {
    case trendingNow
    case popularCategories
    case cuisineByCountry
    case recentRecipe

    
    var title: String {
        switch self {
        case .trendingNow: return "Trending now 🔥"
        case .popularCategories: return "Popular category"
        case .cuisineByCountry: return "Cuisine by Country"
        case .recentRecipe: return "Recent recipe"
            
        }
    }
}

// MARK: - Protocol for Categorization
protocol HeaderType {}
protocol ButtonType {}

// MARK: - Extensions to Categorize Cases
extension SeeAllExploreType: HeaderType {
    static var headerCases: [SeeAllExploreType] {
        return [.trendingNow, .popularCategories, .cuisineByCountry, .recentRecipe]
    }
}

