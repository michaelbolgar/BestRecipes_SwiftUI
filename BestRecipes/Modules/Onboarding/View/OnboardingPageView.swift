//
//  OnboardingPageView.swift
//  BestRecipes
//
//  Created by Артур  Арсланов on 13.08.2025.
//

import SwiftUI

struct OnboardingPageView: View {
    let page: OnboardingPage
    var isFirstPage: Bool = false
    
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
                        colors: [.clear, .black.opacity(0.35), .black.opacity(0.9)],
                        startPoint: .center, endPoint: .bottom
                    )
                )
                .ignoresSafeArea()
                .overlay(alignment: .top) {
                    if isFirstPage {
                        HStack(spacing: 8) {
                            Image(systemName: "star.fill")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.black)
                            Text("100k+")
                                .font(.custom(AppFont.semibold, size: 16))
                                .foregroundColor(.white)
                            Text("Premium recipes")
                                .font(.custom(AppFont.regular, size: 16))
                                .foregroundColor(.white)
                        }
                        .padding(.top, 60)
                        .frame(maxWidth: .infinity)
                    }
                }

            VStack(spacing: 12) {
                coloredTitle
                    .font(.custom(AppFont.semibold, size: isFirstPage ? 56 : 40))
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)

                if !page.subtitle.isEmpty {
                    Text(page.subtitle)
                        .font(.custom(AppFont.regular, size: 16))
                        .foregroundColor(.white.opacity(0.9))
                        .multilineTextAlignment(.center)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 24)
            .padding(.bottom, isFirstPage ? 140 : 120)
        }
    }
}

#Preview {
    OnboardingPageView(page: demoPages[0])
}
