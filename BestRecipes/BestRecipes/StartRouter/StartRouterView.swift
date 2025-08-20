import SwiftUI

struct StartRouterView: View {
    @StateObject var startRouter = StartRouter()

    var body: some View {
        NavigationStack {
            switch startRouter.routerState {
            case .launch:
                LaunchScreen(router: startRouter)
            case .onboarding:
                OnboardingView(vm: OnboardingViewModel(pages: demoPages), onFinish: { printSome() } )
            case .main:
                AppCoordinator()
            }
        }
        .transition(.opacity)
        .animation(.bouncy, value: startRouter.routerState)
    }

    private func printSome() {
        UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
        startRouter.updateRouterState(with: .onboardingCompleted)
    }
}

#Preview {
    StartRouterView()
}
