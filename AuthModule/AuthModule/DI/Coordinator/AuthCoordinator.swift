import SwiftUI
import Core

public final class AuthCoordinator: Coordinator {

    public enum Screen: Routable {
        case login
        case personalInfoRegistration
        case passwordRegistration(PersonalInfoViewModel)
    }

    @Published public var navigationPath = [Screen]()
    
    private let showMainSceneHandler: () -> Void

    public init(showMainSceneHandler: @escaping () -> Void) {
        self.showMainSceneHandler = showMainSceneHandler
    }
}

extension AuthCoordinator: AuthCoordinatorProtocol {

    public func showMainScene() {
        showMainSceneHandler()
    }

    public func showLogin() {
        updatePathForLogin()
        navigationPath.append(.login)
    }

    public func showPersonalInfoRegistration() {
        updatePathForPersonalInfoRegistration()
        navigationPath.append(.personalInfoRegistration)
    }

    public func showPasswordRegistration(personalInfo: PersonalInfoViewModel) {
        navigationPath.append(.passwordRegistration(personalInfo))
    }
}

private extension AuthCoordinator {

    func updatePathForPersonalInfoRegistration() {
        if case .login = navigationPath.last {
            navigationPath.removeLast()
        }
    }

    func updatePathForLogin() {
        switch navigationPath.last {
        case .personalInfoRegistration:
            navigationPath.removeLast()
        case .passwordRegistration:
            navigationPath.removeLast()
            navigationPath.removeLast()
        default: 
            break
        }
    }
}
