import Foundation

public struct Post: Equatable {
    public let id: String
    public let title: String
    public let text: String

    public let userId: String
    public let plantId: String

    public let likesUsers: [UserProfile]
    public let imagesURLs: [String]
    
    public init(
        id: String,
        title: String,
        text: String,
        userId: String,
        plantId: String,
        likesUsers: [UserProfile],
        imagesURLs: [String]
    ) {
        self.id = id
        self.title = title
        self.text = text
        self.userId = userId
        self.plantId = plantId
        self.likesUsers = likesUsers
        self.imagesURLs = imagesURLs
    }
}

public extension Post {
    static var mock: Post {
        .init(
            id: UUID().uuidString,
            title: "Post Title",
            text: "post text post text post text post text post text post text post textpost text post text post text post text post text",
            userId: UUID().uuidString,
            plantId: UUID().uuidString,
            likesUsers: [],
            imagesURLs: ["https://i.pinimg.com/originals/fe/f8/7e/fef87efc5f2f87435fa3015dacff97c8.jpg"]
        )
    }
}
