import SwiftUI
import Core

public struct AuthCoordinatorView: View {

    private let factory: AuthScreenFactory
    
    @ObservedObject private var coordinator: AuthCoordinator

    public init(_ coordinator: AuthCoordinator, factory: ScreenFactory) {
        self.factory = factory as AuthScreenFactory
        self.coordinator = coordinator
    }

    public var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            factory.makeWelcomeView(coordinator: coordinator)
                .navigationDestination(for: AuthCoordinator.Screen.self) {
                    destination($0)
                }
        }
    }

    @ViewBuilder
    private func destination(_ screen: AuthCoordinator.Screen) -> some View {
        switch screen {
        case .login:
            factory.makeLoginView(coordinator: coordinator)
        case .personalInfoRegistration:
            factory.makePersonalInfoRegistrationView(coordinator: coordinator)
        case .passwordRegistration(let personalInfo):
            factory.makePasswordRegistrationView(personalInfo: personalInfo, coordinator: coordinator)
        }
    }
}
