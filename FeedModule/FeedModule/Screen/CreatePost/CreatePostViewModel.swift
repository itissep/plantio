import Foundation
import Core
import Models

final class CreatePostViewModel: ViewModel {

    @Published private(set) var state: CreatePostViewState

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

    func handle(_ event: CreatePostViewEvent) {
        switch event {
        case .createPostTapped:
            feedService.createPost(
                Post(
                    id: UUID().uuidString,
                    title: state.title,
                    text: state.text,
                    user: UserProfile.mock, // TODO: change this
                    plant: Plant.mock, // TODO: change this
                    likesUsers: [],
                    imagesURLs: [], // TODO: state.images,
                    createdAt: .now
                )) { error in
                    if let error {
//                        self.state.
                    } else {
                        // TODO: add show Success or something like this
                        coordinator.showFeedScene()
                    }
                }
        case .titleChanged(let newTitle):
            state.title = newTitle
        case .textChanged(let newText):
            state.text = newText
        case .imageAdded(_):
            print("images was added")
        case .plantAdded(_):
            print("plant was added")
        }
    }
}

private extension CreatePostViewModel {
    func createPostTapped() {
        coordinator.showFeedScene()
    }
}


struct CreatePostViewState: Equatable {
    var title = ""
    var text = ""
    var plant = ""
    var images: [Data] = []
    
    var isCreationEnabled: Bool {
        title != "" && text != ""
    }
}

enum CreatePostViewEvent {
    case createPostTapped
    case titleChanged(String)
    case textChanged(String)
    case imageAdded(Data)
    case plantAdded(Plant)
}
