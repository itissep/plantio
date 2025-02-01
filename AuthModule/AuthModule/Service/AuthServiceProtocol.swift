import Foundation
import Models

public protocol AuthServiceProtocol {
    func logOut() async throws
    func register(user: UserRegister) async throws
    func logIn(credentials: LoginCredentials) async throws
}

public struct UserRegister { #warning("TODO: move this to separated file")
    let userName: String
    let password: String
    let email: String
}
