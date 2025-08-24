//
//  IngredientsCell.swift
//  BestRecipes
//
//  Created by DimaTru on 18.08.2025.
//

import SwiftUI

struct IngredientsCell: View {
    @Binding var itemName: String
    @Binding var quantity: String
    var onDelete: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            TextField("Item name", text: $itemName)
                .frame(width: UIScreen.main.bounds.width * 0.4)
                .padding(.vertical, 12)
                .padding(.horizontal, 15)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.secondary, lineWidth: 1)
                }
            TextField("Quantity", text: $quantity)
                .frame(width: UIScreen.main.bounds.width * 0.2)
                .padding(.vertical, 12)
                .padding(.horizontal, 15)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.secondary, lineWidth: 1)
                }
            Button {
                onDelete()
            } label: {
                Image("minusButtonIcone")
            }
        }
    }
}

//#Preview {
//    IngredientsCell()
//}
