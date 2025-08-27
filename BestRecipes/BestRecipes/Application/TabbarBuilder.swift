import SwiftUI

struct TabbarBuilder: View {
    @State private var selectedTab: Tab = .home

    var body: some View {

        VStack(spacing: 0) {
            ZStack {
                switch selectedTab {
                case .home:
                    HomeContentView()
                case .savedRecipes:
                    SavedRecipesContentView()
                case .plus:
                    CreateRecipeView()
                case .suggestions:
                    SuggestionsContentView()
                case .profile:
                    ProfileContentView()
                }
            }
            .frame(maxHeight: .infinity, alignment: .center)
            Spacer()
            Divider()
            TabbarView(selectedTab: $selectedTab)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
   TabbarBuilder()
        .environmentObject(CoreDataService())
}

