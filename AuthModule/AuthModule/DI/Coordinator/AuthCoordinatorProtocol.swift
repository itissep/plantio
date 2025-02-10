import Foundation

@MainActor
public protocol AuthCoordinatorProtocol {
    func showLogin()
    func showMainScene()
    func showPersonalInfoRegistration()
    func showPasswordRegistration(personalInfo: PersonalInfoViewModel)
}
