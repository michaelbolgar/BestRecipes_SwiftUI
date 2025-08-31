//
//  SeeAllCell.swift
//  BestRecipes
//
//  Created by Келлер Дмитрий on 31.08.2025.
//


import SwiftUI

struct SeeAllCell: View {
    // MARK: - Properties
    let recipe: RecipeModel
    var isFavorited: Bool
    let toggleBookmark: () -> Void
    
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
                
                FavoriteButton(
                    isFavorited: isFavorited,
                    action: toggleBookmark
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .padding(Offsets.x2)
                
                authorView()
                    .padding(.horizontal, Offsets.x1)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(recipe.title)
                        .font(.categoryButtonText)
                        .foregroundStyle(.appWhite)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                    HStack {
                        Text("cooking time")
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
                ShimmerView()
            @unknown default:
                EmptyView()
            }
        }
    }
    
    private func authorView() -> some View {
        Text("by_ \(recipe.author)")
            .font(.custom(AppFont.regular, size: 12))
            .foregroundStyle(.appWhite)
            .lineLimit(1)
            .frame(width: 150)
    }
}

#Preview {
    SeeAllCell(recipe: RecipeModel.popularCategoryMock.first!, isFavorited: true, toggleBookmark: { })
}
