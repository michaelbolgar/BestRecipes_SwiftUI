import SwiftUI

struct StartRouterView: View {
    private let storage = UserDefaultsServiceImpl()
    @StateObject var startRouter = StartRouter()

    var body: some View {
        NavigationStack {
            switch startRouter.routerState {
            case .launch:
                LaunchScreen(router: startRouter)
            case .onboarding:
                OnboardingView(vm: OnboardingViewModel(pages: demoPages), onFinish: { printSome() } )
            case .main:
                TabbarBuilder()
            }
        }
        .transition(.opacity)
        .animation(.bouncy, value: startRouter.routerState)
    }

    private func printSome() {
        storage.recordOnboardingIsCompleted()
        startRouter.updateRouterState(with: .onboardingCompleted)
    }
}

#Preview {
    StartRouterView()
}
