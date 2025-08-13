//
//  OnboardingPageView.swift
//  BestRecipes
//
//  Created by Артур  Арсланов on 13.08.2025.
//

import SwiftUI

struct OnboardingPageView: View {
    let page: OnboardingPage

    private var coloredTitle: Text {
        page.titleParts.reduce(Text("")) { acc, part in
            acc + Text(part.text).foregroundColor(part.color)
        }
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            page.image
                .resizable()
                .scaledToFill()
                .overlay(
                    LinearGradient(
                        gradient: Gradient(colors: [.clear, .black.opacity(0.7), .black]),
                        startPoint: .center, endPoint: .bottom
                    )
                )
                .ignoresSafeArea()

            VStack(spacing: 8) {
                coloredTitle
                    .font(.onboardingTitle)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)

                if !page.subtitle.isEmpty {
                    Text(page.subtitle)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 24)
            .padding(.bottom, 120)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(page.titleParts.map(\.text).joined()) \(page.subtitle)")
    }
}



#Preview {
    OnboardingPageView(page: demoPages[2])
}
