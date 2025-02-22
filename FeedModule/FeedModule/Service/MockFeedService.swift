import Foundation
import Models

public class MockFeedService: FeedServiceProtocol {
    
    public init() { }
    
    public func createPost(_ post: Models.Post, completion: ((any Error)?) -> Void) {
        print("post created")
        completion(nil)
    }
    
    public func getPost(with id: String) -> Post {
        Post.mock
    }
    
    public func getComments(for postId: String) -> [Comment] {
        [Comment.mock, Comment.mock, Comment.mock, Comment.mock, Comment.mock]
    }
    
    public func getPosts() -> [Post] {
        [Post.mock, Post.mock, Post.mock, Post.mock, Post.mock]
    }
}
