import Foundation
import Core

enum WelcomeViewState: Equatable {
    case idle
}

enum WelcomeViewEvent {
    case logInTapped
    case registrationTapped
}

final class WelcomeViewModel: ViewModel {

    @Published private(set) var state: WelcomeViewState
    private let coordinator: AuthCoordinatorProtocol

    init(coordinator: AuthCoordinatorProtocol) {
        state = .idle
        self.coordinator = coordinator
    }

    func handle(_ event: WelcomeViewEvent) {
        switch event {
        case .logInTapped:
            coordinator.showLogin()

        case .registrationTapped:
            coordinator.showPersonalInfoRegistration()
        }
    }
}
