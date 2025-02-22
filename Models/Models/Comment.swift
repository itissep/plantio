import Foundation

public struct Comment: Equatable {
    public let id: String
    public let text: String
    public let user: UserProfile
    public let post: Post?
    public let createdAt: Date
    
    public init(
        id: String,
        text: String,
        user: UserProfile,
        post: Post?,
        createdDate: Date
    ) {
        self.id = id
        self.text = text
        self.user = user
        self.post = post
        self.createdAt = createdDate
    }
}

public extension Comment {
    static var mock: Comment {
        .init(
            id: UUID().uuidString,
            text: "comment text",
            user: UserProfile.mock,
            post: nil,
            createdDate: .now
        )
    }
}
