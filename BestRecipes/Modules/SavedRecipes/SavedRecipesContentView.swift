import SwiftUI

struct SavedRecipesContentView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                SavedRecipesCell()
                SavedRecipesCell()
                SavedRecipesCell()
            }
            .navigationTitle("Saved recipes")
        }
    }
}


#Preview {
    SavedRecipesContentView()
}
