//
//  TrendingNowCell.swift
//  BestRecipes
//
//  Created by Келлер Дмитрий on 17.08.2025.
//

import SwiftUI

struct TrendingNowCell: View {
    // MARK: - Properties
    let recipe: RecipeModel
    
    enum Drawing {
        static let imageHeight: CGFloat = 200
        static let imageCornerRadius: CGFloat = 10
        static let cardWidth: CGFloat = 300
        static let cardHeight: CGFloat = 240
    }
    
    // MARK: - Body
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
                
                
                VStack(alignment: .leading, spacing: Offsets.x1) {
                    RatingView(rating: recipe.spoonacularScore)
                    TimerView(timer: recipe.readyInMinutes)
                }
                .padding(Offsets.x2)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                
                BookmarkView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                
                authorView()
            }
            .clipShape(RoundedRectangle(cornerRadius: Drawing.imageCornerRadius))
            .frame(height: Drawing.imageHeight)
            // Заголовок фиксированной высоты
            Text(recipe.title)
                .font(.custom(AppFont.bold, size: 16))
                .lineLimit(2)
                .padding(.top, Offsets.x1)
        }
        .frame(width: Drawing.cardWidth, height: Drawing.cardHeight)
    }
    
    // MARK: - Subviews
    func authorView() -> some View {
        ZStack {
            HStack {
                Text("by: \(recipe.author)")
                    .lineLimit(1)
                    .font(.custom(AppFont.regular, size: 12))
                    .foregroundStyle(.appWhite)
                Spacer()
            }
        }
        .backgroundRatingStyle(cornerRadius: Offsets.x0)
    }
    
    func imageView() -> some View {
        AsyncImage(url: recipe.image) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            case .failure:
                AppImages.mockImage
                    .resizable()
                    .scaledToFill()
            case .empty:
                ShimmerView()
            @unknown default:
                EmptyView()
            }
        }
    }
}

#Preview {
    TrendingNowCell(recipe: RecipeModel.popularCategoryMock.first!)
}
