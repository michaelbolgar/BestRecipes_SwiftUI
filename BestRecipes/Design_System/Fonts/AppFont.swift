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
    

}

// MARK: - Text Extensions with Font Weights
extension Text {
    
    func recipesNavTitleStyle() -> some View {
        self
            .font(.recipesNavTitle)
            .foregroundStyle(.black)
    }
}
