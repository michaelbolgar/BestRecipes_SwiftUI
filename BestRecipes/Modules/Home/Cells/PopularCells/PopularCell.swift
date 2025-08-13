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
    
    enum Drawing {
        static let roundSize: CGFloat = 110
    }
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Color(.appBackground)
                .ignoresSafeArea()
            VStack(spacing: 0) {
                Spacer().frame(height: Drawing.roundSize / 2)
                
                ZStack(alignment: .bottom) {
                    RoundedRectangle(cornerRadius: Offsets.x3)
                        .frame(width: 150, height: 176)
                        .foregroundStyle(.neutral10)
                    
                    VStack {
                        Text(recipe.title)
                            .recipesTitleStyle()
                            .lineLimit(2)
                            .minimumScaleFactor(0.7)
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Time")
                                    .recipesPlaceholderStyle()
                                
                                Text(recipe.time)
                                    .recipesTitleStyle()
                            }
                            Spacer()
                            BookmarkView()
                        }
                        .padding(.horizontal, 12)
                        .padding(.bottom, 12)
                        .frame(width: 150)
                    }
                }
            }
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
    PopularCell(recipe:
    RecipeModel(
        id: 4,
        title: "Pad Thai",
        image: URL(string: "https://spoonacular.com/recipeImages/664823-312x231.jpg")!,
        spoonacularScore: 92.0,
        time: "5 min"
    ))
}
