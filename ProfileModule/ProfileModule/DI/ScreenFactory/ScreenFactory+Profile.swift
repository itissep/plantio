import Foundation
import Core

extension ScreenFactory: ProfileViewFactory {
    public func makeEditProfileView(coordinator: ProfileCoordinatorProtocol) -> EditProfileView {
        let viewModel = EditProfileViewModel(
            coordinator: coordinator,
            profileService: serviceLocator.resolve()!,
            validateServise: serviceLocator.resolve()!
        )
        return EditProfileView(viewModel: viewModel)
    }
    
   public  func makeProfileView(coordinator: ProfileCoordinatorProtocol) -> ProfileView {
        let viewModel = ProfileViewModel(
            coordinator: coordinator,
            profileService: serviceLocator.resolve()!
        )
        return ProfileView(viewModel: viewModel)
    }
}
