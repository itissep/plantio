import Foundation
import Core

final class PersonalInfoRegistrationViewModel: ViewModel {

    @Published private(set) var state: PersonalInfoRegistrationViewState

    private let coordinator: AuthCoordinatorProtocol
    private let registrationValidationService: RegistrationValidationService

    init(
        coordinator: AuthCoordinatorProtocol,
        registrationValidationService: RegistrationValidationService
    ) {
        self.state = .init()
        self.coordinator = coordinator
        self.registrationValidationService = registrationValidationService
    }

    func handle(_ event: PersonalInfoRegistrationViewEvent) {
        switch event {
        case .logInTapped:
            coordinator.showLogin()

        case .continueTapped:
            continueTapped()

        case .nameChanged(let name):
            state.name = name

        case .usernameChanged(let username):
            usernameUpdated(username)

        case .emailChanged(let email):
            emailUpdated(email)
        }
    }
}

private extension PersonalInfoRegistrationViewModel {

    func emailUpdated(_ email: String) {
        state.email = email
        do {
            try registrationValidationService.validate(email: email)
            state.emailError = nil
        } catch {
            state.emailError = ValidationErrorHandler.message(for: error)
        }
    }

    func usernameUpdated(_ username: String) {
        state.username = username

        do {
            try registrationValidationService.validate(username: username)
            state.usernameError = nil
        } catch {
            state.usernameError = ValidationErrorHandler.message(for: error)
        }
    }

    func continueTapped() {
        let personalInfo = PersonalInfoViewModel(
            userName: state.username,
            name: state.name,
            email: state.email
        )

        coordinator.showPasswordRegistration(personalInfo: personalInfo)
    }
}


struct PersonalInfoRegistrationViewState: Equatable {
    var name = ""
    var username = ""
    var email = ""
    var birthdate = Date.now

    var emailError: String? = ""
    var usernameError: String? = ""

    var isEmailErrorShowing: Bool {
        email.isEmpty == false && emailError != nil
    }

    var isUsernameErrorShowing: Bool {
        username.isEmpty == false && usernameError != nil
    }

    var isContinueDisabled: Bool {
        name.isEmpty || emailError != nil || usernameError != nil
    }
}

enum PersonalInfoRegistrationViewEvent {
    case logInTapped
    case continueTapped
    case nameChanged(String)
    case usernameChanged(String)
    case emailChanged(String)
}


enum ValidationErrorHandler {
    
    #warning("TODO: move error descriptions to errors")

    static func message(for error: Error) -> String {
        if let passwordError = error as? RegistrationValidationService.PasswordValidationError {
            return passwordMessage(passwordError)
        }

        if let usernameError = error as? RegistrationValidationService.UsernameValidationError {
            return usernameMessage(usernameError)
        }

        if let emailError = error as? RegistrationValidationService.EmailValidationError {
            return emailMessage(emailError)
        }

        return "unknownError"
    }

    private static func passwordMessage(
        _ error: RegistrationValidationService.PasswordValidationError
    ) -> String {
        switch error {
        case .invalidPassword:
            return "Password.invalidPassword"
        }
    }

    private static func usernameMessage(
        _ error: RegistrationValidationService.UsernameValidationError
    ) -> String {
        switch error {
        case .invalidUsername:
            return "invalidUsername"
        }
    }

    private static func emailMessage(
        _ error: RegistrationValidationService.EmailValidationError
    ) -> String {
        switch error {
        case .invalidUsername: "invalidUsername"
        case .missingKeySign: "missingKeySign"
        case .invalidDomainPart: "invalidDomainPart"
        case .invalidTopLevelDomain: "invalidTopLevelDomain"
        }
    }
}
