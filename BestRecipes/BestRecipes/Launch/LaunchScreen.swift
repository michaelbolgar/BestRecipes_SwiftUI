import SwiftUI

struct LaunchScreen: View {

    //MARK: Properites
    let router: StartRouter

    // MARK: Init
    init(router: StartRouter) {
        self.router = router
    }

    // MARK: Body
    var body: some View {
        ZStack {
            Color.appWhite
            Image(.search)
                .onAppear()
        }
        .ignoresSafeArea(.all)
    }

    func routeToStart() {
        Task {
            try? await Task.sleep(nanoseconds: 6_000_000_000)
            router.updateRouterState(with: .launchCompleted)
        }
    }
}

#Preview {
    LaunchScreen(router: StartRouter())
}
