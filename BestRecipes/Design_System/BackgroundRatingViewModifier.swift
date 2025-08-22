//
//  BackgroundRatingViewModifier.swift
//  BestRecipes
//
//  Created by Келлер Дмитрий on 21.08.2025.
//


import SwiftUI

struct BackgroundRatingViewModifier: ViewModifier {
    let cornerRadius: CGFloat

    init(cornerRadius: CGFloat = Offsets.x2) {
        self.cornerRadius = cornerRadius
    }

    func body(content: Content) -> some View {
        content
            .padding(.horizontal, Offsets.x2)
            .padding(.vertical, Offsets.x1)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.backgrountRatingView)
                    .opacity(0.5)
            )
    }
}

extension View {
    func backgroundRatingStyle(cornerRadius: CGFloat = Offsets.x2) -> some View {
        self.modifier(BackgroundRatingViewModifier(cornerRadius: cornerRadius))
    }
}
