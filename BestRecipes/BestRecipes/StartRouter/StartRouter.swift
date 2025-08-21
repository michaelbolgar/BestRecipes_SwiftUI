import Foundation

enum RouterState {
    case launch
    case onboarding
    case main
    // can be modified after adding authorization
}

enum StartEvent {
    case launchCompleted
    case onboardingCompleted
}

final class StartRouter: ObservableObject {

    @Published var routerState: RouterState = .launch
    let storage: UserDefaultsService = UserDefaultsServiceImpl()

    func updateRouterState(with event: StartEvent) {
        routerState = handleStateChange(event)
    }

    private func handleStateChange(_ event: StartEvent) -> RouterState {
        switch event {
        case .launchCompleted:
            return rootState()
        case .onboardingCompleted:
            return rootState()
            // can be modified after adding authorization
        }
    }

    private func rootState() -> RouterState {
        guard storage.hasCompletedOnboarding() else {
            return .onboarding
        }
        return .main
    }
}
