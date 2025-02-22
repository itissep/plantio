import Foundation

public struct UserProfile: Equatable {
    public let id: String
    public let nickName: String
    public let name: String
    public let email: String
    public let avatarUrl: String?
    public let description: String?
    
    public init(
        id: String,
        nickName: String,
        name: String,
        email: String,
        avatarUrl: String? = nil,
        description: String? = nil
    ) {
        self.id = id
        self.name = name
        self.email = email
        self.nickName = nickName
        self.avatarUrl = avatarUrl
        self.description = description
    }
}


public extension UserProfile {
    static var mock: UserProfile {
        .init(
            id: UUID().uuidString,
            nickName: "someone",
            name: "someone",
            email: "some@main.com",
            avatarUrl: "https://i.pinimg.com/originals/fe/f8/7e/fef87efc5f2f87435fa3015dacff97c8.jpg"
        )
    }
}
