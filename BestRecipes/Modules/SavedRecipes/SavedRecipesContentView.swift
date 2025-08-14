import SwiftUI

struct SavedRecipesContentView: View {
    var body: some View {
        NavigationStack {
            List {
                SavedRecipesCell()
            }
            .listStyle(.plain)
            .navigationTitle("Saved recipes")
        }
    }
}


#Preview {
    SavedRecipesContentView()
}
