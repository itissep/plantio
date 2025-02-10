import Foundation

public final class AuthService {

//    private let networkService: NetworkService
    private let keychainService: KeychainService

    init(
//        networkService: NetworkService,
        keychainService: KeychainService
    ) {
//        self.networkService = networkService
        self.keychainService = keychainService
    }
}

extension AuthService: AuthServiceProtocol {

    public func logOut() async throws {
//        let config = AuthNetworkConfig.logout
//        try await networkService.request(with: config)
        try keychainService.deleteToken()
    }

    public func logIn(credentials: LoginCredentials) async throws {
//        let data = try networkService.encode(credentials)
//        let config = AuthNetworkConfig.login(data)
//
//        let tokenInfo: TokenInfo = try await networkService.request(with: config)
//        try keychainService.saveToken(tokenInfo.token)
    }

    public func register(user: UserRegister) async throws {
//        let userDto = UserRegisterDTO(
//            userName: user.userName,
//            name: user.name,
//            password: user.password,
//            email: user.email,
//            birthDate: user.birthDate,
//            gender: user.gender == .female ? .female : .male
//        )
//
//        let data = try networkService.encode(userDto)
//        let config = AuthNetworkConfig.register(data)
//
//        let tokenInfo: TokenInfo = try await networkService.request(with: config)
//        try keychainService.saveToken(tokenInfo.token)
    }
}
