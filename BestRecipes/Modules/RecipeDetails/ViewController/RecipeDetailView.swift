//
//  RecipeDetailView.swift
//  BestRecipes
//
//  Created by KOZLOVA Anastasia on 14.08.2025.
//

import SwiftUI

struct RecipeDetailView: View {
  @StateObject var viewModel: RecipeDetailViewModel
    @EnvironmentObject private var coreDataService: CoreDataService
  @State private var ingredientCheckedStatus: [Int: Bool] = [:]

    init(recipeID: Int) {
        self._viewModel = StateObject(wrappedValue: RecipeDetailViewModel(recipeID: recipeID))
    }
    
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
            ForEach(viewModel.items?.extendedIngredients ?? []) { item in
              ingredientSection(item)
            }
          }
        }
      }
    }
    .task {
        viewModel.setCoreDataService(coreDataService)
        await viewModel.fetchRecipeDetails()
    }
      
    .listStyle(.plain)
    .padding(.horizontal, Offsets.x4)
    .navigationBarBackButtonHidden()
    .toolbar {
        ToolbarItem(placement: .topBarLeading) {
            BackBarButtonView()
        }
    }
  }
  
  private func headerSection() -> some View {
    Text(viewModel.items?.title ?? "")
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
      Text("\(viewModel.items?.extendedIngredients.count ?? 0) items")
        .foregroundColor(.secondary)
        .font(.caption)
    }
  }
  
  private func imageSection() -> some View {
    AsyncImage(url: viewModel.items?.image) {
      phase in
      switch phase {
      case .empty:
        ShimmerView()
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
      Text("\(String(format: "%.1f", viewModel.items?.scoreOutOfFive ?? 5))")
        .fontWeight(.semibold)
      Text("(\(Int(viewModel.items?.aggregateLikes ?? 0)) Reviews)")
        .foregroundColor(.secondary)
    }
    .font(.caption)
  }
  
  private func instructionsSection() -> some View {
    ForEach(viewModel.items?.analyzedInstructions.first?.steps ?? []) { item in
      if item.number == viewModel.items?.analyzedInstructions.first?.steps.count {
        Text("\(item.step)")
          .foregroundColor(.redPrimary50)
      } else {
        Text("\(item.number). \(item.step)")
      }
    }
      .lineLimit(nil)
      .allowsTightening(true)
  }
  
  private func ingredientSection(_ ingredient: Ingredient) -> some View {
    ZStack {
      Rectangle()
        .frame(height: 76)
        .foregroundColor(.neutral10)
        .cornerRadius(12)
      HStack(spacing: 12) {
          Group {
              if let image = viewModel.ingredientImage[ingredient.id] {
                  Image(uiImage: image)
                      .resizable()
                      .scaledToFit()
                      .frame(width: 52, height: 52)
                      .background(Color.white)
                      .clipShape(RoundedRectangle(cornerRadius: 8))
              } else {
                  ShimmerView()
              }
          }
        .frame(width: 52, height: 52)
        .onAppear {
            Task {
                print("Загружаем изображение ингредиента: \(ingredient.image)")
                await viewModel.fetchIngredientImage(imageName: ingredient.image, id: ingredient.id)
            }
        }

        Text(ingredient.name.capitalized)
          .font(.recipesMiniTitle)
        Spacer()
        Text("\(Int(ingredient.measures.metric.amount)) \(ingredient.measures.metric.unitShort)")
          .font(.caption)
          .foregroundColor(.secondary)
        CustomCheckbox(isChecked: Binding(get: { ingredientCheckedStatus[ingredient.id, default: false]},
                                          set: { ingredientCheckedStatus[ingredient.id] = $0 })
        )
      }
      .padding(.horizontal, 16)
    }
  }
}

//#Preview("RecipeDetailView") {
//    NavigationStack {
//      RecipeDetailView(recipeID: 323)
//    }
//}
