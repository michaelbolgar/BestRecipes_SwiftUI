

// MARK: - EventType
enum SeeAllType: Hashable, CaseIterable {
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
extension SeeAllType: HeaderType {
    static var headerCases: [SeeAllType] {
        return [.trendingNow, .popularCategories, .cuisineByCountry, .recentRecipe]
    }
}

