import SwiftUI

@MainActor
public protocol ProfileViewFactory {
    func makeProfileView(coordinator: ProfileCoordinatorProtocol) -> ProfileView
    
    func makeEditProfileView(coordinator: ProfileCoordinatorProtocol) -> EditProfileView
}
