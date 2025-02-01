import SwiftUI
import Core
import AuthModule
import PUI

struct AppCoordinatorView: View {

    private let screenFactory: ScreenFactory
    @ObservedObject private var coordinator: AppCoordinator

    init(screenFactory: ScreenFactory, coordinator: AppCoordinator) {
        self.screenFactory = screenFactory
        self.coordinator = coordinator
    }

    var body: some View {
        sceneView
            .onAppear {
                coordinator.handle(.checkAuthorization)
            }
    }

    @ViewBuilder
    private var sceneView: some View {
        switch coordinator.state {
        case .idle:
            EmptyView()

        case .loading:
            PUI.BaseProgressView()

        case .auth:
            AuthCoordinatorView(
                AuthCoordinator { coordinator.handle(.showMain) },
                factory: screenFactory
            )

        case .main:
            Text("MainCoordinatorView")
//            MainCoordinatorView(
//                factory: screenFactory,
//                showAuthSceneHandler: { coordinator.handle(.showAuth) }
//            )
        }
    }
}
