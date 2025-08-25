import SwiftUI

struct SavedRecipesCell: View {
    let recipe: RecipeFavoritable
    let toggleFavorite: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack {
                AsyncImage(url: recipe.imageURL) { phase in
                    switch phase {
                    case .empty:
                        Color.gray.opacity(0.3)
                    case .success(let image):
                        image.resizable().scaledToFill()
                    case .failure:
                        Color.gray.opacity(0.3)
                    @unknown default:
                        Color.gray.opacity(0.3)
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 180)
                .clipShape(RoundedRectangle(cornerRadius: 10))

                RatingView(rating: recipe.recipeDetails.spoonacularScore)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)

                TimerView(timer: recipe.readyInMinutes)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)

                BookmarkButton(isBookmarked: recipe.isFavorited, action: toggleFavorite)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            }
            .frame(height: 180)

            Text(recipe.title)
                .font(.custom(AppFont.bold, size: 16))
                .padding(.vertical, 12)

            HStack(spacing: 8) {
                Image("mockImage")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .clipShape(Circle())
                Text("By \(recipe.author)")
                    .font(.custom(AppFont.regular, size: 12))
                    .foregroundStyle(.secondary)
            }
        }
    }
}
