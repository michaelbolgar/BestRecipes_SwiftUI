//
//  DotsIndicator.swift
//  BestRecipes
//
//  Created by Артур  Арсланов on 13.08.2025.
//

import SwiftUI

struct DotsIndicator: View {
    let count: Int
    let index: Int
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<count, id: \.self) { i in
                Circle()
                    .frame(width: i == index ? 10 : 8, height: i == index ? 10 : 8)
                    .opacity(i == index ? 1.0 : 0.4)
                    .foregroundStyle(.white)
                    .animation(.easeInOut(duration: 0.2), value: index)
            }
        }
        .padding(.horizontal, 16)
    }
}
