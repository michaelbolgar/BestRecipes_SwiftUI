import SwiftUI

struct RecentRecipesCell: View {

    // MARK: - Properties
    let recipe: RecentRecipesModel

    enum Constants {
        static let cellWidth: CGFloat = 125
        static let cornerRadius: CGFloat = 12
    }

    // MARK: - Body
    var body: some View {
        ZStack {
            Color(.appBackground)
                .ignoresSafeArea()
            VStack(spacing: Offsets.x2) {
                    Image(.testPicture)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: Constants.cellWidth, height: Constants.cellWidth)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))

                VStack(alignment: .leading, spacing: Offsets.x0) {
                        Text(recipe.title)
                            .recipesTitleStyle()
                            .lineLimit(2)
                            .minimumScaleFactor(0.9)

                        Text("By \(recipe.author)")
                            .recipesPlaceholderStyle()
                            .lineLimit(1)
                            .minimumScaleFactor(0.9)
                }
            }
            .frame(width: 125)
        }
    }
}

#Preview {
    RecentRecipesCell(recipe:
    RecentRecipesModel(
        id: 4,
        title: "Some Tasty American Food",
        image: URL(string: "https://spoonacular.com/recipeImages/664823-312x231.jpg")!,
        author: "Gordon Ramsay"
    ))
}
