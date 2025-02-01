import Core

extension ScreenFactory: AuthScreenFactory {
    func makeWelcomeView(coordinator: AuthCoordinatorProtocol) -> WelcomeView {
        let viewModel = WelcomeViewModel(coordinator: coordinator)
        let view = WelcomeView(viewModel: viewModel)

        return view
    }
    
    func makeLoginView(coordinator: AuthCoordinatorProtocol) -> LoginView {
        let viewModel = LoginViewModel(
            coordinator: coordinator,
            authService: serviceLocator.resolve()! // TODO: find out what to do with this
        )
        let view = LoginView(viewModel: viewModel)

        return view
    }
    
    func makePersonalInfoRegistrationView(
        coordinator: AuthCoordinatorProtocol
    ) -> PersonalInfoRegistrationView {
        let viewModel = PersonalInfoRegistrationViewModel(
            coordinator: coordinator,
            registrationValidationService: serviceLocator.resolve()! // TODO: find out what to do with this
        )
        let view = PersonalInfoRegistrationView(viewModel: viewModel)

        return view
    }
    
    func makePasswordRegistrationView(
        personalInfo: PersonalInfoViewModel,
        coordinator: AuthCoordinatorProtocol
    ) -> PasswordRegistrationView {
        let viewModel = PasswordRegistrationViewModel(
            personalInfo: personalInfo,
            coordinator: coordinator,
            authService: serviceLocator.resolve()!, // TODO: find out what to do with this
            registrationValidationService: serviceLocator.resolve()! // TODO: find out what to do with this
        )
        let view = PasswordRegistrationView(viewModel: viewModel)

        return view
    }
}

