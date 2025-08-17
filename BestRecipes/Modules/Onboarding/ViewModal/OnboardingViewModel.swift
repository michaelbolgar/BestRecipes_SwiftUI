//
//  OnboardingViewModel.swift
//  BestRecipes
//
//  Created by Артур  Арсланов on 13.08.2025.
//

import SwiftUI

final class OnboardingViewModel: ObservableObject {
    @Published var pages: [OnboardingPage]
    @Published var index: Int = 0
    
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = false
    
    init(pages: [OnboardingPage]) {
        self.pages = pages
    }
    
    var isLastPage: Bool {
        index == pages.count - 1
    }
    
    func next(onFinish: () -> Void) {
        if isLastPage {
            hasSeenOnboarding = true
            onFinish()
        } else {
            withAnimation {
                index += 1
            }
        }
    }
    
    func skip(onFinish: () -> Void) {
        hasSeenOnboarding = true
        onFinish()
        print("Skip")
    }
}
