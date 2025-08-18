//
//  OnboardingView.swift
//  BestRecipes
//
//  Created by Артур  Арсланов on 13.08.2025.
//

import SwiftUI

import SwiftUI

struct OnboardingView: View {
    @StateObject var vm: OnboardingViewModel
    var onFinish: () -> Void

    private var showPager: Bool { vm.index > 0 }
    private var showSkip:  Bool { vm.index > 0 && !vm.isLastPage }

    var body: some View {
        ZStack {
            pagesPager
            bottomBar
        }
        .ignoresSafeArea()
        .statusBarHidden(true)
    }
}

// MARK: - Subviews
private extension OnboardingView {
    var pagesPager: some View {
        TabView(selection: $vm.index) {
            ForEach(vm.pages.indices, id: \.self) { i in
                OnboardingPageView(page: vm.pages[i], isFirstPage: i == 0)
                    .tag(i)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }

    var bottomBar: some View {
        VStack {
            Spacer()
            
            let pillsCount = max(0, vm.pages.count - 1)
            let pillsIndex = max(0, vm.index - 1)

            PagerPills(count: pillsCount, index: pillsIndex)
                .opacity(showPager ? 1 : 0)
                .allowsHitTesting(showPager)
                .frame(height: 18)
                .padding(.bottom, 12)

            primaryButton
                .padding(.horizontal, 24)

            Button(action: { vm.skip(onFinish: onFinish) }) {
                Text("Skip")
                    .font(.system(size: 14))
                    .foregroundColor(.white.opacity(0.6))
            }
            .opacity(showSkip ? 1 : 0)
            .allowsHitTesting(showSkip)
            .accessibilityHidden(!showSkip)
            .padding(.top, 8)

            Spacer().frame(height: 24)
        }
    }

    @ViewBuilder
    var primaryButton: some View {
        if vm.index == 0 {
            RedButtonRect(
                title: vm.pages[0].textButtom.isEmpty ? "Get started" : vm.pages[0].textButtom,
                action: { withAnimation { vm.index = 1 } }
            )
        } else {
            RedButtonCapsule(
                title: vm.pages[vm.index].textButtom.isEmpty
                        ? (vm.isLastPage ? "Start Cooking" : "Continue")
                        : vm.pages[vm.index].textButtom,
                action: { vm.next(onFinish: onFinish) }
            )
        }
    }
}

#Preview {
    OnboardingView(vm: OnboardingViewModel(pages: demoPages), onFinish: {})
}
