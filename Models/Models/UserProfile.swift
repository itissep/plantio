import Foundation

public struct UserProfile: Codable {
    let id: String
    let nickname: String
    let avatarUrl: String?
    let description: String?
}
