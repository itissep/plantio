import Foundation

public struct Post: Equatable {
    public let id: String
    public let title: String
    public let text: String
    public let createdAt: Date

    public let user: UserProfile
    public let plant: Plant

    public let likesUsers: [UserProfile]
    public let imagesURLs: [String]
    
    public init(
        id: String,
        title: String,
        text: String,
        user: UserProfile,
        plant: Plant,
        likesUsers: [UserProfile],
        imagesURLs: [String],
        createdAt: Date
    ) {
        self.id = id
        self.title = title
        self.text = text
        self.user = user
        self.plant = plant
        self.likesUsers = likesUsers
        self.imagesURLs = imagesURLs
        self.createdAt = createdAt
    }
}

public extension Post {
    static var mock: Post {
        .init(
            id: UUID().uuidString,
            title: "Post Title",
            text: "post text post text post text post text post text post text post textpost text post text post text post text post text",
            user: UserProfile.mock,
            plant: Plant.mock,
            likesUsers: [],
            imagesURLs: ["https://i.pinimg.com/originals/fe/f8/7e/fef87efc5f2f87435fa3015dacff97c8.jpg"],
            createdAt: .now
        )
    }
}
