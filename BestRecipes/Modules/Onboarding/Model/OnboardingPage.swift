//
//  OnboardingPage.swift
//  BestRecipes
//
//  Created by Артур  Арсланов on 13.08.2025.
//

import SwiftUI

struct OnboardingTextPart {
    let text: String
    let color: Color
}

struct OnboardingPage: Identifiable {
    let id = UUID()
    let titleParts: [OnboardingTextPart]
    let subtitle: String
    let textButtom: String
    let image: Image
}
