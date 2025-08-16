enum Tab: String {
    case home
    case savedRecipes
    case notification
    case profile
    case plus

    var activeTab: String { rawValue + "Active" }
    var inactiveTab: String { rawValue + "Inactive" }
}
