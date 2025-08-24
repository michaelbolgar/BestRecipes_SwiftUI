import SwiftUI
import PhotosUI

struct CreateRecipeView: View {
    // MARK: - Properties
    @EnvironmentObject var coredataService: CoreDataService
    @StateObject private var keyboard = KeyboardObserver()
    
    @State private var title = ""
    @State private var serves: Int = 0
    @State private var cookTime: Int = 0
    @State private var ingredients: [IngredientCreatedRecipe] = []
    
    @State private var selectedPhoto: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    
    @State private var showSavedAlert = false
    
    // MARK: - Body
    var body: some View {
            ScrollView {
                VStack(spacing: 16) {
                    ZStack {
                        if let selectedImageData, let uiImage = UIImage(data: selectedImageData) {
                           Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(height: 200)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        } else {
                            Image("mockImage")
                                .resizable()
                                .frame(height: 200)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        
                        PhotosPicker(
                            selection: $selectedPhoto,
                            matching: .images,
                            photoLibrary: .shared()
                        ) {
                            Image("Edit")
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                    }
                    
                    TextField("Naija lunch box ideas for work|", text: $title)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 15)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.red, lineWidth: 1)
                        }
                    
                    CustomButton(
                        image: "Serves",
                        title: "Serves",
                        selectedValue: $serves
                    )
                    
                    CustomButton(
                        image: "CookTime",
                        title: "CookTime",
                        selectedValue: $cookTime
                    )
                    
                    LazyVStack(alignment: .leading) {
                        Text("Ingredients")
                            .font(.custom(AppFont.bold, size: 20))
                        ForEach($ingredients) { $ingredient in
                            IngredientsCell(
                                itemName: $ingredient.name,
                                quantity: $ingredient.quantity,
                                onDelete: {
                                    if let index = ingredients.firstIndex(where: {$0.id == ingredient.id}) {
                                        ingredients.remove(at: index)
                                    }
                                }
                            )
                        }
                        
                        Button {
                            ingredients.append(IngredientCreatedRecipe(name: "", quantity: ""))
                        } label: {
                            HStack {
                                Image("plus")
                                Text("Add new Ingredient")
                                    .font(.custom(AppFont.bold, size: 16))
                                    .foregroundStyle(.black)
                            }
                        }
                    }
                    
                    RedButtonRect(
                        title: "Create recipe",
                        action: {saveRecipe()
                        }
                    )
                }
            }
            .scrollDismissesKeyboard(.interactively)
            .navigationTitle("Create recipe")
            .navigationBarTitleDisplayMode(.inline)
        
            .safeAreaInset(edge: .bottom, spacing: 0) {
                Color.clear
                    .frame(height: keyboard.keyboardHeight)
                    .animation(.easeOut(duration: 0.25), value: keyboard.keyboardHeight)
            }
            .padding(.horizontal, 12)
            .background(Color.clear.contentShape(Rectangle()).onTapGesture {
                hideKeyboard()
            })
            .onChange(of: selectedPhoto) { newValue in
                Task {
                    if let data = try? await newValue?.loadTransferable(type: Data.self) {
                        selectedImageData = data
                    }
                }
            }
            .alert("Recipe saved!", isPresented: $showSavedAlert) {
                        Button("OK", role: .cancel) { }
                    }
        }
    
    // MARK: - Save Recipe Method
    private func saveRecipe() {
        let dictIngredients = Dictionary(uniqueKeysWithValues: ingredients.map {($0.name, $0.quantity)})
       coredataService.createCreatedRecipe(
        title: title,
        serves: serves,
        cookTime: cookTime,
        ingredients: dictIngredients,
        imageData: selectedImageData
       )
        showSavedAlert = true
        hideKeyboard()
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    CreateRecipeView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
