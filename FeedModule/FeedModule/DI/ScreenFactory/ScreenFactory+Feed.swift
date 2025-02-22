import Foundation
import Core

extension ScreenFactory: FeedViewFactory {
    
    public func makeCreatePostView(coordinator: FeedCoordinatorProtocol) -> CreatePostView {
        let viewModel = CreatePostViewModel(coordinator: coordinator, feedService: serviceLocator.resolve()!)
        return CreatePostView(viewModel: viewModel)
    }
    
    public func makeFeedView(coordinator: FeedCoordinatorProtocol) -> FeedView {
        let viewModel = FeedViewModel(coordinator: coordinator, feedService: serviceLocator.resolve()!)
        return FeedView(viewModel: viewModel)
    }
    
    public func makePostView(coordinator: FeedCoordinatorProtocol, postId: String) -> PostDetailsView {
        let viewModel = PostDetailsViewModel(
            coordinator: coordinator,
            feedService: serviceLocator.resolve()!,
            postId: postId
        )
        return PostDetailsView(viewModel: viewModel)
    }
    
//    public func makeEditProfileView(coordinator: ProfileCoordinatorProtocol) -> EditProfileView {
//        let viewModel = EditProfileViewModel(
//            coordinator: coordinator,
//            profileService: serviceLocator.resolve()!,
//            validateServise: serviceLocator.resolve()!
//        )
//        return EditProfileView(viewModel: viewModel)
//    }
//    
//   public  func makeProfileView(coordinator: ProfileCoordinatorProtocol) -> ProfileView {
//        let viewModel = ProfileViewModel(
//            coordinator: coordinator,
//            profileService: serviceLocator.resolve()!
//        )
//        return ProfileView(viewModel: viewModel)
//    }
}
