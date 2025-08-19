//
//  TrendingNowCell.swift
//  BestRecipes
//
//  Created by Келлер Дмитрий on 19.08.2025.
//


import SwiftUI

struct SearchRecipeCell: View {
    // MARK: - Properties
    let recipe: RecipeModel
    
    enum Drawing {
        static let imageHeight: CGFloat = 200
        static let imageCornerRadius: CGFloat = 10
    }
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                imageView()
                LinearGradient(
                    gradient: Gradient(colors: [
                        .black.opacity(0.7),
                        .black.opacity(0.1)
                    ]),
                    startPoint: .bottom,
                    endPoint: .top
                )
                .clipShape(
                    RoundedRectangle(cornerRadius: Drawing.imageCornerRadius)
                )
                
                RatingView(rating: recipe.spoonacularScore)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(Offsets.x2)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(recipe.title)
                        .font(.categoryButtonText)
                        .foregroundStyle(.appWhite)
                    HStack {
                        Text("\(recipe.readyInMinutes) Ingredients")
                        Text("|")
                        Text(recipe.readyInMinutes)
                    }
                    .font(.custom(AppFont.regular, size: 12))
                    .foregroundStyle(.appWhite)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                .padding(Offsets.x4)
            }
            .frame(maxWidth: .infinity, minHeight: Drawing.imageHeight, maxHeight: Drawing.imageHeight)
        }
    }
    
    // MARK: - Views
    private func imageView() -> some View {
        AsyncImage(url: recipe.image) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(height: Drawing.imageHeight)
                    .clipShape(
                        RoundedRectangle(cornerRadius: Drawing.imageCornerRadius))
            case .failure:
                AppImages.mockImage
                    .resizable()
                    .scaledToFill()
                    .frame(height: Drawing.imageHeight)
                    .clipShape(
                        RoundedRectangle(cornerRadius: Drawing.imageCornerRadius))
            case .empty:
                ShimmerView(ratio: 1)
            @unknown default:
                EmptyView()
            }
        }
    }
}

#Preview {
    SearchRecipeCell(recipe: RecipeModel.popularCategoryMock.first!)
}
