import Foundation
import Core

public class FeedCoordinator: Coordinator {

    public enum Screen: Routable {
        case feed
        case post(String)
        case createPost
//        case sharePost
    }

    @Published public var navigationPath = [Screen]()

    public init() { }
}

extension FeedCoordinator: FeedCoordinatorProtocol {
    public func showCreatePostScene() {
        navigationPath.append(.createPost)
    }
    
    public func showPostDetailsScene(with id: String) {
        navigationPath.append(.post(id))
    }
    
    public func showFeedScene() {
        navigationPath.append(.feed)
    }
    
    public func showSharePostScene() {
        print("going to show sharing")
    }
}
