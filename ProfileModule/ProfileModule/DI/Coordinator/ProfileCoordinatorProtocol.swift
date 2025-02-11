import Foundation

@MainActor
public protocol ProfileCoordinatorProtocol {
    func showAuthScene()
    func showEditProfileScene()
    func showShareProfileScene()
}
