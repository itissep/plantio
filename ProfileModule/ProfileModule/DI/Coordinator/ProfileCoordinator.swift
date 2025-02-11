import Foundation
import Core

public final class ProfileCoordinator: Coordinator {

    public enum Screen: Routable {
        case profile
        case editProfile
//        case shareProfile
    }

    @Published public var navigationPath = [Screen]()
    private let showAuthSceneHandler: () -> Void

    public init(showAuthSceneHandler: @escaping () -> Void) {
        self.showAuthSceneHandler = showAuthSceneHandler
    }
}

extension ProfileCoordinator: ProfileCoordinatorProtocol {
    public func showEditProfileScene() {
        navigationPath.append(.editProfile)
    }
    
    public func showShareProfileScene() {
        print("going to show sharing")
    }
    

    public func showAuthScene() {
        showAuthSceneHandler()
    }
}
