import Foundation
import SwiftUI

struct AppFont {
    static let bold: String = "Poppins-Bold"
    static let semibold: String = "Poppins-SemiBold"
    static let regular: String = "Poppins-Regular"
}

// MARK: - Font Extensions for BestRecipesApp
extension Font {
    static let recipesNavTitle = Font.custom(AppFont.bold, size: 24)
    static let recipesMaxTitle = Font.custom(AppFont.semibold, size: 20)
    static let recipesTitle = Font.custom(AppFont.semibold, size: 12)
    static let recipesMiniTitle = Font.custom(AppFont.semibold, size: 14)
    static let placeholderText = Font.custom(AppFont.regular, size: 14)
    static let commentText = Font.custom(AppFont.regular, size: 12)
    static let categoryButtonText = Font.custom(AppFont.semibold, size: 16)
}

// MARK: - Text Extensions with Font Weights
extension Text {
    
    func recipesNavTitleStyle() -> some View {
        self
            .font(.recipesNavTitle)
            .foregroundStyle(.neutral100)
    }
    
    func recipesPlaceholderStyle() -> some View {
        self
            .font(.placeholderText)
            .foregroundStyle(.neutral30)
    }
    
    func commentStyle() -> some View {
        self
            .font(.commentText)
            .foregroundStyle(.neutral30)
    }
    
    func recipesMaxTitleStyle() -> some View {
        self
            .font(.recipesMaxTitle)
            .foregroundStyle(.neutral100)
    }
    
    func recipesTitleStyle() -> some View {
        self
            .font(.recipesTitle)
            .foregroundStyle(.neutral100)
    }
    
    func recipesSeeAllTextStyle() -> some View {
        self
            .font(.recipesMiniTitle)
            .foregroundStyle(.redPrimary50)
    }
    
    func recipesCategoryButtonStyle() -> some View {
        self
            .font(.categoryButtonText)
            .foregroundStyle(.redPrimary20)
    }
    
}
