import SwiftUI

struct SavedRecipesCell: View {
    let recipe: RecipeFavoritable
    let toggleBookmark: () -> Void

    enum Drawing {
        static let imageHeight: CGFloat = 200
        static let imageCornerRadius: CGFloat = 10
        static let cardHeight: CGFloat = 240
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .bottom) {
                ZStack {
                    imageView()

                    LinearGradient(
                        gradient: Gradient(colors: [
                            .black.opacity(0.2),
                            .black.opacity(0.01)
                        ]),
                        startPoint: .bottom,
                        endPoint: .top
                    )
                }
                .frame(height: Drawing.imageHeight)

                VStack(alignment: .leading, spacing: 4) {
                    RatingView(rating: recipe.recipeDetails.spoonacularScore)
                    TimerView(timer: "\(recipe.recipeDetails.readyInMinutes) min")
                }
                .padding(8)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)

                BookmarkButton(isBookmarked: recipe.isFavorited, action: toggleBookmark)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)

                authorView()
            }
            .clipShape(RoundedRectangle(cornerRadius: Drawing.imageCornerRadius))
            .frame(height: Drawing.imageHeight)

            Text(recipe.recipeDetails.title)
                .font(.custom(AppFont.bold, size: 16))
                .lineLimit(2)
                .padding(.top, 4)
        }
        .frame(maxWidth: .infinity)
        .frame(height: Drawing.cardHeight)
        .padding(.horizontal)
    }

    func authorView() -> some View {
        ZStack {
            HStack {
                Text("by: \(recipe.recipeDetails.author)")
                    .lineLimit(1)
                    .font(.custom(AppFont.regular, size: 12))
                    .foregroundStyle(.appWhite)
                Spacer()
            }
        }
        .backgroundRatingStyle(cornerRadius: 4)
    }

    func imageView() -> some View {
        AsyncImage(url: recipe.imageURL) { phase in
            switch phase {
            case .success(let image):
                image.resizable().scaledToFill()
            case .failure:
                AppImages.mockImage.resizable().scaledToFill()
            case .empty:
                ShimmerView()
            @unknown default:
                EmptyView()
            }
        }
    }
}

#Preview {
    SavedRecipesCell(recipe: RecipeFavoritable(recipeDetails: RecipeModel(id: 1, title: "Delicious Beef", image: URL(string: "https://spoonacular.com/recipeImages/716429-312x231.jpg")!, author: "Michael", spoonacularScore: 4.8, readyInMinutes: "50"), isFavorited: true), toggleBookmark: {} )
}
