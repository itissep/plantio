import Foundation

public struct UserProfile: PlantlyModel {
    public let id: String
    let nickName: String
    let avatarUrl: String?
    let description: String?
    
    public init(id: String, nickName: String, avatarUrl: String? = nil, description: String? = nil) {
        self.id = id
        self.nickName = nickName
        self.avatarUrl = avatarUrl
        self.description = description
    }
}
