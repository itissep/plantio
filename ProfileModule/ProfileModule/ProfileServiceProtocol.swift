import Foundation
import Models

enum ProfileServiceError: Error {
    case noLocalProfile
}

public protocol ProfileServiceProtocol {
    func deleteProfile() async
    func getProfile() async throws -> UserProfile
    func updateProfile(_ profile: UserProfile) async throws
}
