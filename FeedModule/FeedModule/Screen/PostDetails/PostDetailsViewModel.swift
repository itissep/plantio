import Foundation
import Core
import Models

final class PostDetailsViewModel: ViewModel {
    @Published private(set) var state: PostDetailsViewState

    private let coordinator: FeedCoordinatorProtocol
    private let feedService: FeedServiceProtocol

    init(
        coordinator: FeedCoordinatorProtocol,
        feedService: FeedServiceProtocol,
        postId: String
    ) {
        self.state = .init()
        self.coordinator = coordinator
        self.feedService = feedService

    }

    func handle(_ event: PostDetailsViewEvent) {
        switch event {
        case .onAppear:
            Task { await fetchComments() }
        case .onEdit:
            coordinator.showCreatePostScene() // TODO: change to edit
        case .onAlertPresented(_):
            print("alert presenting")
        case .onReload:
            Task { await fetchComments() }
        case .onDeletePostTapped:
            print("post deletion alert?") // TODO: post deleting alert
        case .onLike:
            print("post liked")
        }
    }
}

private extension PostDetailsViewModel {

    func handleError(_ error: Error) {
//        if error as? AuthError == .unauthorized {
//            coordinator.showAuthScene()
//        } else {
            state.errorMessage = error.localizedDescription
            state.isAlertPresenting = true
//        }
    }

    func fetchComments() async {
        state.isLoading = true
        do {
            self.state.comments = feedService.getComments(for: state.post.id)
            state.isLoading = false
        } catch {
            state.errorMessage = error.localizedDescription
            state.isLoading = false
        }
    }
}
