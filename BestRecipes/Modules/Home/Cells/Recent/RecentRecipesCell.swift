import SwiftUI

struct RecentRecipesCell: View {

    // MARK: - Properties
    let recipe: RecentRecipesModel

    enum Constants {
        static let cellWidth: CGFloat = 145
        static let cellHeight: CGFloat = 190
        static let cornerRadius: CGFloat = 12
    }

    // MARK: - Body
    var body: some View {
        ZStack {
            Color(.appBackground)
                .ignoresSafeArea()
            asyncImageView()
                .frame(width: Constants.cellWidth, height: Constants.cellHeight)
                .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
            bluring()
            recipeName()
        }
        .frame(width: Constants.cellWidth, height: Constants.cellHeight)
    }


    // MARK: Helper methods
    private func asyncImageView() -> some View {
        if let url = URL(string: recipe.imageString) {
            return AnyView(
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        Color.gray
                            .opacity(0.3)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()

                    case .failure(_):
                        AppImages.mockImage
                            .resizable()
                            .scaledToFill()
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
            )
        } else {
            return AnyView(
                Image(.testPicture)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: Constants.cellWidth, height: Constants.cellHeight)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
            )
        }
    }

    private func bluring() -> some View {
        VStack {
            Spacer()
            Rectangle()
                .fill(Color.white.opacity(0.75))
                .frame(height: Constants.cellHeight / 4)
                .blur(radius: 4)
        }
        .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
    }

    private func recipeName() -> some View {
        VStack(alignment: .leading, spacing: Offsets.x0) {
            Text(recipe.title)
                .recipesTitleStyle()
                .lineLimit(2)
                .minimumScaleFactor(0.9)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
        .padding(.horizontal, Offsets.x1)
        .padding(.bottom, Offsets.x1)
    }
}

#Preview {
    RecentRecipesCell(recipe:
        RecentRecipesModel(
            id: 4,
            title: "Some Tasty American Food",
            imageString: "https://spoonacular.com/recipeImages/664823-312x231.jpg",
            author: "Gordon Ramsay"
        )
    )
}

