import SwiftUI

struct StartRouterView: View {
    @StateObject var startRouter = StartRouter()

    var body: some View {
        NavigationStack {
            switch startRouter.routerState {
            case .launch:
                MockContentView()
            case .onboarding:
                OnboardingView(vm: OnboardingViewModel(pages: demoPages), onFinish: {} )
            case .main:
                AppCoordinator()
            }
        }
        .transition(.opacity)
        .animation(.bouncy, value: startRouter.routerState)
    }
}

#Preview {
    StartRouterView()
}
