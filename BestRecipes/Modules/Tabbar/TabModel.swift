enum Tab: Int, CaseIterable, Hashable {
    case home
    case savedRecipes
    case notification
    case profile
    case plus

    var icon: String {
        switch self {
        case .home:
            return TabName.home
        case .savedRecipes:
            return TabName.savedRecipes
        case .notification:
            return TabName.notification
        case .profile:
            return TabName.profile
        case .plus:
            return TabName.plus
        }
    }
}

enum TabName {
    static let home = "home"
    static let savedRecipes = "savedRecipes"
    static let notification = "notification"
    static let profile = "profile"
    static let plus = "plusButton"
}

