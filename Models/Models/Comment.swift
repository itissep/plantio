import Foundation

public struct Comment: Equatable {
    public let id: String
    public let text: String
    public let user: UserProfile
    public let post: Post?
    
    public init(
        id: String,
        text: String,
        user: UserProfile,
        post: Post?
    ) {
        self.id = id
        self.text = text
        self.user = user
        self.post = post
    }
}

public extension Comment {
    static var mock: Comment {
        .init(
            id: UUID().uuidString,
            text: "comment text",
            user: UserProfile(
                id: UUID().uuidString,
                nickName: "someone",
                name: "someone",
                email: ""
            ),
            post: nil
        )
    }
}
