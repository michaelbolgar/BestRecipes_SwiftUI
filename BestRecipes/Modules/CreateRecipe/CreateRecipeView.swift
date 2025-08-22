import SwiftUI

struct CreateRecipeView: View {
    @State private var text = ""
    @State private var ingredients: [String] = []
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    ZStack {
                        Image("mockImage")
                            .resizable()
                            .frame(height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        Button {
                            //action
                        } label: {
                            Image("Edit")
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                    }
                    
                    TextField("Naija lunch box ideas for work|", text: $text)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 15)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.red, lineWidth: 1)
                        }
                    
                    CustomButton(image: "Serves", title: "Serves")
                    CustomButton(image: "CookTime", title: "CookTime")
                    
                    LazyVStack(alignment: .leading) {
                        Text("Ingredients")
                            .font(.custom(AppFont.bold, size: 20))
                        ForEach(ingredients.indices, id: \.self) { index in
                            IngredientsCell(
                                onDelete: {
                                    ingredients.remove(at: index)
                                }
                            )
                        }
                        
                        Button {
                            ingredients.append("")
                        } label: {
                            HStack {
                                Image("plus")
                                Text("Add new Ingredient")
                                    .font(.custom(AppFont.bold, size: 16))
                                    .foregroundStyle(.black)
                            }
                        }
                    }
                    
                    RedButtonRect(title: "Create recipe", action: { })
                }
            }
            .navigationTitle("Create recipe")
            .padding(.horizontal, 12)
        }
    }
}

#Preview {
    CreateRecipeView()
}
