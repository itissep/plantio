import SwiftUI

@MainActor
public protocol FeedViewFactory {
    func makeFeedView(coordinator: FeedCoordinatorProtocol) -> FeedView
    func makeCreatePostView(coordinator: FeedCoordinatorProtocol) -> CreatePostView
    func makePostView(coordinator: FeedCoordinatorProtocol, postId: String) -> PostDetailsView
}
