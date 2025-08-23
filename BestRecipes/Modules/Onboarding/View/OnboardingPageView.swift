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
    var bottomInset: CGFloat = 0
    
    private var attributedTitle: AttributedString {
        var result = AttributedString()
        for part in page.titleParts {
            var s = AttributedString(part.text)
            s.foregroundColor = part.color
            result += s
        }
        return result
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            page.image
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
            
                .overlay(
                    LinearGradient(
                        colors: [.clear, .black.opacity(0.35), .black.opacity(0.9)],
                        startPoint: .center, endPoint: .bottom
                    )
                    .ignoresSafeArea(edges: .bottom)
                )
                .allowsHitTesting(false)
            
            VStack(spacing: 12) {
                Text(attributedTitle)
                    .font(.custom(AppFont.semibold, size: isFirstPage ? 56 : 40))
                    .multilineTextAlignment(.center)
                    .lineSpacing(2)
                    .frame(maxWidth: .infinity)
                
                if !page.subtitle.isEmpty {
                    Text(page.subtitle)
                        .font(.custom(AppFont.regular, size: 16))
                        .foregroundColor(.white.opacity(0.9))
                        .multilineTextAlignment(.center)
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, bottomInset + (isFirstPage ? 36 : 28))
        }
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
                .allowsHitTesting(false)
            }
        }
        .contentShape(Rectangle())
    }
}

#Preview {
    OnboardingPageView(page: demoPages[3])
}
