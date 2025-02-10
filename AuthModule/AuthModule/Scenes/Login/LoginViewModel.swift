import Foundation
import Core

struct LoginViewState: Equatable {
    var username = ""
    var password = ""

    var isLoading = false
    var loginError: String?

    var isLogInDisabled: Bool {
        username.isEmpty || password.isEmpty
    }

    var isLoginErrorShowing: Bool {
        loginError != nil && isLoading == false
    }
}

enum LoginViewEvent {
    case logInTapped
    case registerTapped
    case usernameChanged(String)
    case passwordChanged(String)
}

final class LoginViewModel: ViewModel {
    
    @Published private(set) var state: LoginViewState
    
    private let coordinator: AuthCoordinatorProtocol
    private let authService: AuthServiceProtocol
    
    init(coordinator: AuthCoordinatorProtocol, authService: AuthServiceProtocol) {
        state = .init()
        self.authService = authService
        self.coordinator = coordinator
    }
    
    func handle(_ event: LoginViewEvent) {
        switch event {
        case .logInTapped:
            Task { await logInTapped() }

        case .registerTapped:
            coordinator.showPersonalInfoRegistration()
            
        case .usernameChanged(let login):
            state.username = login
            
        case .passwordChanged(let password):
            state.password = password
        }
    }
}

private extension LoginViewModel {
    
    func logInTapped() async {
        state.isLoading = true
        do {
            let credentials = LoginCredentials(username: state.username, password: state.password)
            try await authService.logIn(credentials: credentials)
            state.loginError = nil
            coordinator.showMainScene()
        } catch {
            state.loginError = "loginFailed"
        }
        state.isLoading = false
    }
}
