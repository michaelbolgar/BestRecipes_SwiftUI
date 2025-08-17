//
//  RecipeDetailView.swift
//  BestRecipes
//
//  Created by KOZLOVA Anastasia on 14.08.2025.
//

import SwiftUI

struct RecipeDetailView: View {
  @ObservedObject var viewModel: RecipeDetailViewModel
  @State var isIngredientChecked: Bool

  var body: some View {
    ZStack(alignment: .top) {
        Color.appBackground
        .ignoresSafeArea(.all)
      ScrollView(showsIndicators: false) {
        VStack(alignment: .leading) {
          headerSection()
          imageSection()
            .padding(.bottom, Offsets.x4)
          markSection()
            .padding(.bottom, Offsets.x1)
          titleSection(title: "Instructions")
          instructionsSection()
            .padding(.bottom, Offsets.x6)
          ingredientsTitleSection()
          VStack {
            ForEach(viewModel.items.ingredients) { item in
              ingredientSection(item)
            }
          }
        }
      }
    }
    .listStyle(.plain)
    .padding(.horizontal, Offsets.x4)
    .navigationTitle("Recipe detail")
    .navigationBarTitleDisplayMode(.inline)
    .navigationBarBackButtonHidden()
    .toolbar {
        ToolbarItem(placement: .topBarLeading) {
            BackBarButtonView()
        }
    }
  }
  
  private func headerSection() -> some View {
    Text(viewModel.items.title)
      .recipesNavTitleStyle()
      .lineLimit(2)
      .allowsTightening(true)
  }
  
  private func titleSection(title: String) -> some View {
    Text(title)
      .recipesMaxTitleStyle()
  }
  
  private func ingredientsTitleSection() -> some View {
    HStack {
      titleSection(title: "Ingredients")
      Spacer()
      Text("\(viewModel.items.ingredients.count) items")
        .foregroundColor(.secondary)
        .font(.caption)
    }
  }
  
  private func imageSection() -> some View {
    AsyncImage(url: viewModel.items.image) {
      phase in
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
  }
  
  private func markSection() -> some View {
    HStack {
      Image(systemName: "star.fill")
        .foregroundColor(.black)
      Text("\(String(format: "%.1f", viewModel.items.mark))")
        .fontWeight(.semibold)
      Text("(\(viewModel.items.numbersOfReviews) Reviews)")
        .foregroundColor(.secondary)
    }
    .font(.caption)
  }
  
  private func instructionsSection() -> some View {
    Text(viewModel.items.instructionText)
      .lineLimit(nil)
      .allowsTightening(true)
  }
  
  private func ingredientSection(_ ingredient: IngredientMock) -> some View {
    ZStack {
      Rectangle()
        .frame(height: 76)
        .foregroundColor(.neutral10)
        .cornerRadius(12)
      HStack(spacing: 12) {
        AsyncImage(url: ingredient.image) {
          phase in
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
        .frame(maxWidth: 52)
        .frame(height: 52)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        Text(ingredient.name)
          .font(.recipesMiniTitle)
        Spacer()
        Text("\(ingredient.weight)g")
          .font(.caption)
          .foregroundColor(.secondary)
        CustomCheckbox(isChecked: $isIngredientChecked)
      }
      .padding(.horizontal, 16)
    }
  }
}

#Preview("RecipeDetailView") {
    NavigationStack {
      RecipeDetailView(viewModel: RecipeDetailViewModel(), isIngredientChecked: false)
    }
}
