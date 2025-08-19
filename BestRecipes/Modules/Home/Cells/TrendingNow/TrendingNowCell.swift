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
        static let imageHeight: CGFloat = 180
        static let imageConrerRadius: CGFloat = 10
    }
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                AsyncImage(url: recipe.image) { phase in
                    switch phase {
                        
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(height: Drawing.imageHeight)
                            .clipShape(
                                RoundedRectangle(cornerRadius: Drawing.imageConrerRadius))
                    case .failure:
                        AppImages.mockImage
                            .resizable()
                            .scaledToFill()
                            .frame(height: Drawing.imageHeight)
                            .clipShape(
                                RoundedRectangle(cornerRadius: Drawing.imageConrerRadius))
                    case .empty:
                        ShimmerView(ratio: 1)
                    @unknown default:
                        EmptyView()
                    }
                }
                RatingView(rating: recipe.spoonacularScore)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                
                TimerView(timer: recipe.readyInMinutes)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                
                BookmarkView()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            }
            .frame(height: 180)
            
            HStack {
                Text(recipe.title)
                    .font(.custom(AppFont.bold, size: 16))
            }
            .padding(.vertical, 12)
            
            HStack {
                Image("mockImage")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .clipShape(Circle())
                Text(recipe.author)
                    .font(.custom(AppFont.regular, size: 12))
                    .foregroundStyle(.neutral100)
            }
        }
    }
}

#Preview {
    TrendingNowCell(recipe: RecipeModel.popularCategoryMock.first!)
}
