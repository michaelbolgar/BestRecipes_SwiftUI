//
//  DemoPages.swift
//  BestRecipes
//
//  Created by Артур  Арсланов on 13.08.2025.
//

import SwiftUI

let demoPages: [OnboardingPage] = [
    .init(
        titleParts: [
            .init(text: "Best ", color: .white),
            .init(text: "Recipe", color: .white)
        ],
        subtitle: "Find best recipes for cooking",
        textButtom: "Get started",
        image: Image("startPage")
    ),
    .init(
        titleParts: [
            .init(text: "Recipes from\nall over the\n", color: .white),
            .init(text: "World", color: .orangeRating100)
        ],
        subtitle: "",
        textButtom: "Continue",
        image: Image("cookPage1")
    ),
    .init(
        titleParts: [
            .init(text: "Recipes with\n", color: .white),
            .init(text: "each and every\ndetail", color: .orangeRating100)
        ],
        subtitle: "",
        textButtom: "Continue",
        image: Image("cookPage2")
    ),
    .init(
        titleParts: [
            .init(text: "Cook it now or\n", color: .white),
            .init(text: "save it for later", color: .orangeRating100)
        ],
        subtitle: "",
        textButtom: "Start Cooking",
        image: Image("cookPage3")
    )
]
