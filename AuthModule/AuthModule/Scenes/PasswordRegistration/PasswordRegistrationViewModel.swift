import Foundation
import Core
import Models

final class PasswordRegistrationViewModel: ViewModel {

    @Published private(set) var state: PasswordRegistrationViewState

    private var personalInfo: PersonalInfoViewModel
    private let coordinator: AuthCoordinatorProtocol
    
    private let registrationValidationService: RegistrationValidationService
    private let authService: AuthServiceProtocol

    init(
        personalInfo: PersonalInfoViewModel,
        coordinator: AuthCoordinatorProtocol,
        authService: AuthServiceProtocol,
        registrationValidationService: RegistrationValidationService
    ) {
        self.state = .init()
        self.personalInfo = personalInfo
        self.coordinator = coordinator
        self.authService = authService
        self.registrationValidationService = registrationValidationService
    }

    func handle(_ event: PasswordRegistrationViewEvent) {
        switch event {
        case .logInTapped:
            coordinator.showLogin()

        case .registerTapped:
            Task { await registerTapped() }

        case .passwordChanged(let password):
            passwordUpdated(password)

        case .confirmPasswordChanged(let password):
            confirmPasswordUpdated(password)
        }
    }
}

private extension PasswordRegistrationViewModel {

    func confirmPasswordUpdated(_ confirmPassword: String) {
        state.confirmPassword = confirmPassword

        if state.password == confirmPassword {
            state.confirmPasswordError = nil
        } else {
            state.confirmPasswordError = "invalidConfirmPassword"
        }
    }

    func passwordUpdated(_ password: String) {
        state.password = password

        if password == state.confirmPassword,
           state.confirmPassword.isEmpty == false {
            state.confirmPasswordError = nil
        }

        do {
            try registrationValidationService.validate(password: password)
            state.passwordError = nil
        } catch {
            state.passwordError = ValidationErrorHandler.message(for: error)
        }
    }

    func registerTapped() async {
        let userRegister = UserRegister(
            userName: personalInfo.userName,
            password: state.password,
            email: personalInfo.email
        )

        state.isLoading = true
        do {
            try await authService.register(user: userRegister)
            state.registerError = nil
            coordinator.showMainScene()
        } catch {
            state.registerError = "registrationFailed"
        }
        state.isLoading = false
    }
}


struct PasswordRegistrationViewState: Equatable {
    var password = ""
    var confirmPassword = ""

    var registerError: String?
    var passwordError: String? = ""
    var confirmPasswordError: String? = ""

    var isLoading = false

    var isRegisterErrorShowing: Bool {
        registerError != nil && isLoading == false
    }
    
    var isPasswordErrorShowing: Bool {
        password.isEmpty == false && passwordError != nil
    }

    var isConfirmPasswordErrorShowing: Bool {
        confirmPassword.isEmpty == false && confirmPasswordError != nil
    }

    var isRegisterDisabled: Bool {
        passwordError != nil || confirmPasswordError != nil
    }
}

enum PasswordRegistrationViewEvent {
    case logInTapped
    case registerTapped
    case passwordChanged(String)
    case confirmPasswordChanged(String)
}
