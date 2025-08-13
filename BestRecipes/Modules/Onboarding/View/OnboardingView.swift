//
//  OnboardingView.swift
//  BestRecipes
//
//  Created by Артур  Арсланов on 13.08.2025.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject var vm: OnboardingViewModel
    var onFinish: () -> Void
    
    var body: some View {
        ZStack {
            TabView(selection: $vm.index) {
                ForEach(Array(vm.pages.enumerated()), id: \.1.id) { i, page in
                    OnboardingPageView(page: page)
                        .tag(i)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .ignoresSafeArea()
            
            VStack {
                HStack {
                    Spacer()
                    Button("Skip") { vm.skip(onFinish: onFinish) }
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.top, 8)
                }
                Spacer()
                
                DotsIndicator(count: vm.pages.count, index: vm.index)
                    .padding(.bottom, 12)
                
                
                Group {
                    if vm.index == 0 {
                        RedButtonRect(
                            title: vm.pages[vm.index].textButtom,
                            action: { vm.next(onFinish: onFinish)
                            }
                        )

                    } else {
                        RedButtonCapsule(
                            title: vm.pages[vm.index].textButtom,
                            action: { vm.next(onFinish: onFinish) }
                        )
                    }
                }
                
                .padding(.horizontal, 24)
                .padding(.bottom, 64)
            }
            
            .ignoresSafeArea(.all, edges: .bottom)
        }
        .statusBarHidden(true)
    }
}


#Preview {
    OnboardingView(vm: OnboardingViewModel(pages: demoPages), onFinish: {})
}
