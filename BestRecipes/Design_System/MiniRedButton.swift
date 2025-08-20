//
//  MiniRedButton.swift
//  BestRecipes
//
//  Created by Келлер Дмитрий on 19.08.2025.
//
import SwiftUI

struct MiniRedButton: View {
    var title: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding(Offsets.x1)
                .background(.redPrimary50)
                .clipShape(Capsule())
        }
    }
}

#Preview {
    MiniRedButton(title: "Cancel") {
        print("tap")
    }
}
