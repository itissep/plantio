import Foundation
import Security

public final class KeychainService {

    enum KeychainError: LocalizedError {
        case invalidData
        case itemNotFound
        case duplicateItem
        case incorrectAttributeForClass
        case unexpectedStatus(OSStatus)

        var errorDescription: String? {
            switch self {
            case .invalidData: "Invalid data"
            case .itemNotFound: "Item not found"
            case .duplicateItem: "Duplicate Item"
            case .incorrectAttributeForClass: "Incorrect Attribute for Class"
            case .unexpectedStatus(let status): "Unexpected error - \(status)"
            }
        }
    }

    private enum Key: String {
        case accessToken
    }
}

public extension KeychainService {

    func deleteToken() throws {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: Key.accessToken.rawValue
        ] as CFDictionary

        let status = SecItemDelete(query)

        guard status == errSecSuccess else { throw convertError(status) }
    }

    func saveToken(_ token: String) throws {
        guard let data = token.data(using: .utf8) else { throw KeychainError.invalidData }

        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecValueData: data,
            kSecAttrAccount: Key.accessToken.rawValue
        ] as CFDictionary

        let status = SecItemAdd(query, nil)

        guard status == errSecSuccess else { throw convertError(status) }
    }

    func updateToken(_ newToken: String) throws {
        guard let data = newToken.data(using: .utf8) else { return }

        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: Key.accessToken
        ] as CFDictionary
        let attributesToUpdate = [kSecValueData: data] as CFDictionary

        let status = SecItemUpdate(query, attributesToUpdate)

        guard status == errSecSuccess else { throw convertError(status) }
    }

    func retrieveToken() throws -> String {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: Key.accessToken.rawValue,
            kSecMatchLimit: kSecMatchLimitOne,
            kSecReturnData: kCFBooleanTrue as Any
        ] as CFDictionary

        var result: AnyObject?
        let status = SecItemCopyMatching(query, &result)

        guard status == errSecSuccess else { throw convertError(status) }

        guard let data = result as? Data else { throw KeychainError.invalidData }

        let token = String(decoding: data, as: UTF8.self)
        return token
    }
}

private extension KeychainService {

    func convertError(_ status: OSStatus) -> KeychainError {
        switch status {
        case errSecItemNotFound: .itemNotFound
        case errSecDataTooLarge: .invalidData
        case errSecDuplicateItem: .duplicateItem
        default: .unexpectedStatus(status)
        }
    }
}
