import Foundation
import Models

struct PostDetailsViewState: Equatable {
    var post: Post = Post.mock
    var comments: [Comment] = []
    
    // Service
    var isLoading = false
    var isAlertPresenting = false
    var errorMessage: String = ""
}

enum PostDetailsViewEvent {
    case onAppear
    case onAlertPresented(Bool)
    case onReload
    
    case onDeletePostTapped
    case onLike
    case onEdit
}
