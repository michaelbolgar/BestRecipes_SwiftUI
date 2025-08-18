//
//  CreateRecipeView.swift
//  BestRecipes
//
//  Created by DimaTru on 17.08.2025.
//

import SwiftUI

struct CreateRecipeView: View {
    @State private var text = ""
    
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
