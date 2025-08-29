//
//  PopularCell.swift
//  BestRecipes
//
//  Created by Келлер Дмитрий on 13.08.2025.
//

import SwiftUI

struct PopularCell: View {
    // MARK: - Properties
    let recipe: RecipeModel
    var isFavorited: Bool
    let toggleBookmark: () -> Void

    enum Drawing {
        static let roundSize: CGFloat = 110
    }
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Color(.appBackground)
                .ignoresSafeArea()
            VStack(spacing: 0) {
                Spacer().frame(height: Drawing.roundSize / 3)

                ZStack(alignment: .bottom) {
                    RoundedRectangle(cornerRadius: Offsets.x3)
                        .frame(width: 150, height: 176)
                        .foregroundStyle(.neutral10)
                    
                    VStack {
                        Text(recipe.title)
                            .recipesTitleStyle()
                            .lineLimit(2)
                            .truncationMode(.tail)
                            .multilineTextAlignment(.center)
                            .minimumScaleFactor(0.9)
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Time")
                                    .recipesPlaceholderStyle()
                                
                                Text(recipe.readyInMinutes)
                                    .recipesTitleStyle()
                            }
                            Spacer()
                            FavoriteButton(
                                isFavorited: isFavorited,
                                action: toggleBookmark
                            )
                        }
                        .padding(.leading, Offsets.x3)
                        .padding(.trailing, Offsets.x1)
                        .padding(.bottom, Offsets.x2)
                    }
                }
            }
            .frame(width: 150)
            .overlay(roundImageView(), alignment: .top)
        }
    }
    
    // MARK: - Helper Methods
    private func roundImageView() -> some View {
        AsyncImage(url: recipe.image) { phase in
            switch phase {
            case .empty:
                ShimmerCircle(size: Drawing.roundSize)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: Drawing.roundSize, height: Drawing.roundSize)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray.opacity(0.3), lineWidth: 1))
            case .failure:
                AppImages.mockImage
                    .resizable()
                    .scaledToFill()
                    .frame(width: Drawing.roundSize, height: Drawing.roundSize)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray.opacity(0.3), lineWidth: 1))
            @unknown default:
                EmptyView()
            }
        }
        .zIndex(1)
    }
}

#Preview {
    PopularCell(recipe: RecipeModel.trendingMockBookable.first!, isFavorited: false, toggleBookmark: {})
}
