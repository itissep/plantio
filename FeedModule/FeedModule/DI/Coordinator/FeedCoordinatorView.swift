import SwiftUI

public struct FeedCoordinatorView: View {

    private let factory: FeedViewFactory
    @ObservedObject private var coordinator: FeedCoordinator
    
    public init(_ coordinator: FeedCoordinator, factory: FeedViewFactory) {
        self.factory = factory
        self.coordinator = coordinator
    }
    
    public var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            factory.makeFeedView(coordinator: coordinator)
                .navigationDestination(for: FeedCoordinator.Screen.self) {
                    destination($0)
                }
        }
    }
    
    @ViewBuilder
    private func destination(_ screen: FeedCoordinator.Screen) -> some View {
        switch screen {
        case .feed:
            factory.makeFeedView(coordinator: coordinator)
        case .createPost:
            factory.makeCreatePostView(coordinator: coordinator)
        case .post(let id):
            factory.makePostView(coordinator: coordinator, postId: id)
//        case .shareProfile:
////            Text("sharing")
        }
    }
}
