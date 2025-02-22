import Foundation
import Models

struct FeedViewState: Equatable {
    var posts: [Post] = [
        Post.mock
    ]
    
    // Service
    var isLoading = false
    var isAlertPresenting = false
    var errorMessage: String = ""
}

enum FeedViewEvent {
    case onAppear
    case onAlertPresented(Bool)
    case onReload
    
    case onAddPostTapped
    case onPostSelectWithId(String)
}
