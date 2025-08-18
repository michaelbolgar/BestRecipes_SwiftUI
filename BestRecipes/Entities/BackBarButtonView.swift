//
//  BackBarButtonView.swift
//  BestRecipes
//
//  Created by Келлер Дмитрий on 17.08.2025.
//
import SwiftUI

struct BackBarButtonView: View {
    // MARK: - Properties
    @Environment(\.dismiss) var dismiss
    
    // MARK: - Drawing Constants
    private struct Drawing {
        static let iconSize: CGFloat = 24
    }
    
    // MARK: - Body
    var body: some View {
        Button(action: { dismiss() }) {
            Image(systemName: "arrow.left")
                .resizable()
                .scaledToFit()
                .frame(width: Drawing.iconSize, height: Drawing.iconSize)
                .foregroundStyle(.glass)
        }
    }
}
