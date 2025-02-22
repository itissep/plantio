import Foundation

@MainActor
public protocol FeedCoordinatorProtocol {
    func showCreatePostScene()
    func showPostDetailsScene(with id: String)
    func showFeedScene()
}
