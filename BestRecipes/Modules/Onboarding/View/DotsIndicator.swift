//
//  DotsIndicator.swift
//  BestRecipes
//
//  Created by Артур  Арсланов on 13.08.2025.
//

import SwiftUI

struct PagerPills: View {
    let count: Int
    let index: Int

    var spacing: CGFloat = 12
    var inactiveWidth: CGFloat = 22
    var activeWidth: CGFloat = 28
    var height: CGFloat = 6
    var inactiveColor: Color = .white.opacity(0.85)
    var strokeColor: Color = .white.opacity(0.2)

    var activeGradient = LinearGradient(
        colors: [Color(red: 1.0, green: 0.72, blue: 0.80),
                 Color(red: 1.0, green: 0.70, blue: 0.40)],
        startPoint: .leading, endPoint: .trailing
    )

    var body: some View {
        HStack(spacing: spacing) {
            ForEach(0..<count, id: \.self) { i in
                Capsule()
                    .fill(i == index ? AnyShapeStyle(activeGradient) : AnyShapeStyle(inactiveColor))
                    .frame(width: i == index ? activeWidth : inactiveWidth, height: height)
                    .overlay(
                        Capsule().stroke(strokeColor, lineWidth: 1)
                    )
                    .shadow(color: .black.opacity(0.15), radius: 2, y: 1)
                    .animation(.spring(response: 0.25, dampingFraction: 0.8), value: index)
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Page \(index + 1) of \(count)")
    }
}
