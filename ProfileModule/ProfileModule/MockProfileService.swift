import Foundation
import Models

public final class MockProfileService: ProfileServiceProtocol {
    
    public init() { }
    
    public func deleteProfile() async {
        print("deleted")
    }
    
    public func getProfile() async throws -> UserProfile {
        UserProfile(
            id: "something",
            nickName: "gui",
            name: "someone",
            email: "someone@.email.cpm",
            avatarUrl: "https://modernglamwoc.wordpress.com/wp-content/uploads/2010/06/peach-orange.gif",
            description: "fanstastic person"
        )
//        throw ProfileServiceError.noLocalProfile
    }
    
    public func updateProfile(_ profile: UserProfile) async throws {
        print("updated")
    }
}
