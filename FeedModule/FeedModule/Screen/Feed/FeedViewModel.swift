import Foundation
import Core
import Models

final class FeedViewModel: ViewModel {
    @Published private(set) var state: FeedViewState

    private let coordinator: FeedCoordinatorProtocol
    private let feedService: FeedServiceProtocol

    init(
        coordinator: FeedCoordinatorProtocol,
        feedService: FeedServiceProtocol
    ) {
        self.state = .init()
        self.coordinator = coordinator
        self.feedService = feedService
    }

    func handle(_ event: FeedViewEvent) {
        switch event {
        case .onAppear:
            Task { await fetchPosts() }
//        case .onEditProfileTapped:
//            coordinator.showEditProfileScene()
//        case .onAddPlantTapped:
//            print("wow")
//        case .onAddFriendsTapped:
//            print("wow")
//        case .onShareButtonTapped:
//            print("going to show share view")
//        case .onSortTypeChanged:
//            print("wow")
//        case .onPlantSelectWithId(_):
//            print("wow")
//        case .onFriendSelectWithId(_):
//            print("wow")
//        case .onAlertPresented(_):
//            print("wow")
        case .onAlertPresented(_):
            print("alert presenting")
        case .onReload:
            Task { await fetchPosts() }
        case .onAddPostTapped:
            coordinator.showCreatePostScene()
        case .onPostSelectWithId(let id):
            coordinator.showPostDetailsScene(with: id)
        }
    }
}

private extension FeedViewModel {

    func handleError(_ error: Error) {
//        if error as? AuthError == .unauthorized {
//            coordinator.showAuthScene()
//        } else {
            state.errorMessage = error.localizedDescription
            state.isAlertPresenting = true
//        }
    }

    func fetchPosts() async {
        state.isLoading = true
        do {
            self.state.posts = feedService.getPosts()
            state.isLoading = false
        } catch {
            state.errorMessage = error.localizedDescription
            state.isLoading = false
        }
    }
}
