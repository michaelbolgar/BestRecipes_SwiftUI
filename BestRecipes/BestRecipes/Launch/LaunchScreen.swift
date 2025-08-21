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
            Image(.logo)
                .resizable()
                .frame(width: 300, height: 300)
                .scaledToFill()
                .onAppear(perform: routeToStart)
        }
        .ignoresSafeArea(.all)
    }

    func routeToStart() {
        Task {
            try? await Task.sleep(nanoseconds: 3_000_000_000)
            router.updateRouterState(with: .launchCompleted)
        }
    }
}

#Preview {
    LaunchScreen(router: StartRouter())
}
