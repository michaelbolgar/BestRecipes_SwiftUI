//
//  OnboardingView.swift
//  BestRecipes
//
//  Created by Артур  Арсланов on 13.08.2025.
//

import SwiftUI

struct OnboardingView: View {
    @ObservedObject var vm: OnboardingViewModel
    var onFinish: () -> Void
    
    @State private var bottomInset: CGFloat = 0
    
    private var clampedIndex: Int {
        guard !vm.pages.isEmpty else { return 0 }
        return min(max(vm.index, 0), vm.pages.count - 1)
    }
    private var showPager: Bool { clampedIndex > 0 }
    private var showSkip:  Bool { clampedIndex > 0 && !vm.isLastPage }
    
    var body: some View {
        TabView(selection: $vm.index) {
            ForEach(vm.pages.indices, id: \.self) { i in
                OnboardingPageView(
                    page: vm.pages[i],
                    isFirstPage: i == 0,
                    bottomInset: bottomInset
                )
                .tag(i)
            }
        }
        .ignoresSafeArea()
        .tabViewStyle(.page(indexDisplayMode: .never))
        .background(Color.black.ignoresSafeArea())
        .safeAreaInset(edge: .bottom) {
            bottomBar
                .padding(.bottom, 12)
                .background(
                    GeometryReader { g in
                        Color.clear
                            .preference(key: BottomBarHeightKey.self, value: g.size.height)
                    }
                )
        }
        .onPreferenceChange(BottomBarHeightKey.self) { bottomInset = $0 }
    }
    
    private var bottomBar: some View {
        VStack(spacing: 0) {
            let pillsCount = max(0, vm.pages.count - 1)
            let pillsIndex = max(0, clampedIndex - 1)
            
            PagerPills(count: pillsCount, index: pillsIndex)
                .opacity(showPager ? 1 : 0)
                .allowsHitTesting(showPager)
                .frame(height: 18)
                .padding(.bottom, 12)
            
            primaryButton
                .padding(.horizontal, 24)
            
            Button { vm.skip(onFinish: onFinish) } label: {
                Text("Skip")
                    .font(.system(size: 14))
                    .foregroundColor(.white.opacity(0.6))
            }
            .opacity(showSkip ? 1 : 0)
            .allowsHitTesting(showSkip)
            .accessibilityHidden(!showSkip)
            .padding(.top, 8)
        }
        .padding(.top, 8)
        .background(Color.black.opacity(0.001))
    }
    
    @ViewBuilder
    private var primaryButton: some View {
        if clampedIndex == 0 {
            RedButtonRect(
                title: vm.pages[0].textButtom.isEmpty ? "Get started" : vm.pages[0].textButtom,
                action: { withAnimation { vm.index = 1 } }
            )
        } else {
            let t = vm.pages[clampedIndex].textButtom
            RedButtonCapsule(
                title: t.isEmpty ? (vm.isLastPage ? "Start Cooking" : "Continue") : t,
                action: { vm.next(onFinish: onFinish) }
            )
        }
    }
}

private struct BottomBarHeightKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}


#Preview {
    OnboardingView(vm: OnboardingViewModel(pages: demoPages), onFinish: {})
}
