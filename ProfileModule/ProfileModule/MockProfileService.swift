import Foundation
import Models

public final class MockProfileService: ProfileServiceProtocol {
    
    public init() { }
    
    public func deleteProfile() async {
        print("deleted")
    }
    
    public func getProfile() async throws -> UserProfile {
//        UserProfile(id: UUID().uuidString, nickName: "mock user")
        throw ProfileServiceError.noLocalProfile
    }
    
    public func updateProfile(_ profile: UserProfile) async throws {
        print("updated")
    }
}
