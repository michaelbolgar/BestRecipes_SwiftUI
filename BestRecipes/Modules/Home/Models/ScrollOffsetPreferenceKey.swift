//
//  ScrollOffsetPreferenceKey.swift
//  BestRecipes
//
//  Created by Келлер Дмитрий on 19.08.2025.
//

import SwiftUI

enum ScrollOffsetNamespace {
    static let namespace = "scrollView"
    static let homeNamespace = "homeNamespace"
}

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero

    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
    }
}
