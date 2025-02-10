import Foundation

@MainActor
protocol AuthScreenFactory {
    func makeLoginView(coordinator: AuthCoordinatorProtocol) -> LoginView
    
    func makeWelcomeView(coordinator: AuthCoordinatorProtocol) -> WelcomeView
    
    func makePersonalInfoRegistrationView(
        coordinator: AuthCoordinatorProtocol
    ) -> PersonalInfoRegistrationView
    
    func makePasswordRegistrationView(
        personalInfo: PersonalInfoViewModel,
        coordinator: AuthCoordinatorProtocol
    ) -> PasswordRegistrationView
}
