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

                fetchImage()

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

    // MARK: Helper methods

    /// func for fetching Image from UserDefaults
    private func fetchImage() -> some View {
        /// uncomment after implementring UserDefault
        //        if let data = UserDefaults.standard.data(forKey: "recipe"),
        //               let uiImage = UIImage(data: data.image) {
        //                Image(uiImage: uiImage)
        //                    .resizable()
        //                    .aspectRatio(contentMode: .fill)
        //                    .frame(width: Constants.cellWidth, height: Constants.cellWidth)
        //                    .clipped()
        //                    .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
        //            } else {

        /// this code must stay here as a default image in case the image can't be fetched
        shapeImage(image: Image(.testPicture))
    }

    /// func for shaping given image for RecentRecipe cell
    private func shapeImage(image: Image) -> some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: Constants.cellWidth, height: Constants.cellWidth)
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
    }

    /// func for bluring given image
    private func blurImage(image: Image) -> some View {
        fetchImage()
    }
}

struct BluredImage: View {

    var body: some View {
        ZStack {
//            Image(recipe.image)
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
