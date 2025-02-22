import Foundation
import Models

public protocol FeedServiceProtocol {
    func getPost(with id: String) -> Post
    func getComments(for postId: String) -> [Comment]
    func getPosts() -> [Post]
    
    func createPost(_ post: Post, completion: (Error?) -> Void)
}
