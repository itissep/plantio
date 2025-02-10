import Foundation

public final class MockAuthService: AuthServiceProtocol {
    
    public init() { }
    
    public func logOut() async throws {
        print("logged out")
    }
    
    public func register(user: UserRegister) async throws {
        print("registered")
    }
    
    public func logIn(credentials: LoginCredentials) async throws {
        print("logged in")
    }
}
