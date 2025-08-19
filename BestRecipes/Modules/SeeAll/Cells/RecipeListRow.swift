//
//  RecipeListRow.swift
//  BestRecipes
//
//  Created by Sergey Zakurakin on 8/13/25.
//

import SwiftUI

struct RecipeListRow: View {
    let recipe: RecipeModel

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack {
                AsyncImage(url: recipe.image) { phase in
                    switch phase {
                    case .empty:
                        ShimmerView(ratio: 1)
                    case .success(let image):
                        image.resizable().scaledToFill()
                    case .failure:
                        AppImages.mockImage.resizable().scaledToFill()
                    @unknown default:
                        Color.neutral10
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 16))

                RatingView(rating: recipe.ratingOutOfFive)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)

                BookmarkView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)

                TimerView(timer: recipe.readyInMinutes)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            }
            .frame(height: 200)

            Text(recipe.title)
                .font(.custom(AppFont.bold, size: 20))
                .foregroundStyle(.neutral100)
                .padding(.top, 12)
                .multilineTextAlignment(.leading)

            HStack(spacing: 8) {
                Image("mockImage")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .clipShape(Circle())
                Text(recipe.author)
                    .font(.custom(AppFont.regular, size: 14))
                    .foregroundStyle(.neutral100)
            }
            .padding(.top, 6)
        }
    }
}

/// меняет рейтинг с API в диапазоне от 0 до 100, в шкалу от 0 до 5
private extension RecipeModel {
    var ratingOutOfFive: Double {
        let raw = (spoonacularScore / 100.0) * 5.0
        return (raw * 2).rounded() / 2
    }
}


#Preview {
    RecipeListRow(recipe: RecipeModel.mockData[0])
        .padding()
        .background(Color.appBackground)
}
