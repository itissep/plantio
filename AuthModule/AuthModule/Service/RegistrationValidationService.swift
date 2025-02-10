import Foundation

public final class RegistrationValidationService {

    enum PasswordValidationError: Error {
        case invalidPassword
    }
    
    enum UsernameValidationError: Error {
        case invalidUsername
    }
    
    enum EmailValidationError: Error {
        case invalidUsername
        case missingKeySign
        case invalidDomainPart
        case invalidTopLevelDomain
    }

    private enum Constants {
        static let minPasswordLength = 6
        
        static let formatString = "SELF MATCHES %@"
        static let regex = "[a-zA-Z0-9]+"
        
        static let usernamePartRegex = "[A-Z0-9a-z._%+-]+"
        static let domainPartRegex = "[A-Za-z0-9.-]+"
        static let topLevelDomainRegex = "^[A-Za-z]{2,64}"
    }
    
    public init() { }

    func validate(email: String) throws {
        guard isValidUsername(email) else {
            throw EmailValidationError.invalidUsername
        }

        guard isContainsKeySign(email) else {
            throw EmailValidationError.missingKeySign
        }

        guard isValidDomainPart(email) else {
            throw EmailValidationError.invalidDomainPart
        }

        guard isValidTopLevelDomain(email) else {
            throw EmailValidationError.invalidTopLevelDomain
        }
    }

    func validate(password: String) throws {
        guard password.count >= Constants.minPasswordLength else {
            throw PasswordValidationError.invalidPassword
        }
    }

    func validate(username: String) throws {
        let usernamePredicate = NSPredicate(
            format: Constants.formatString,
            Constants.regex
        )
        
        guard usernamePredicate.evaluate(with: username) else {
            throw UsernameValidationError.invalidUsername
        }
    }

    private func isContainsKeySign(_ email: String) -> Bool {
        email.contains("@")
    }

    private func getEmailUsernamePart(_ email: String) -> String {
        email.components(separatedBy: "@").first ?? ""
    }

    private func getEmailTopLevelDomain(_ email: String) -> String {
        email.components(separatedBy: ".").last ?? ""
    }

    private func getEmailDomainPart(_ email: String) -> String {
        guard let index = email.firstIndex(of: "@") else { return "" }
        let substring = email[email.index(after: index)...]

        return substring.components(separatedBy: ".").first ?? ""
    }

    private func isValidUsername(_ email: String) -> Bool {
        let usernamePartPredicate = NSPredicate(
            format: Constants.formatString,
            Constants.usernamePartRegex
        )

        return usernamePartPredicate.evaluate(with: getEmailUsernamePart(email))
    }

    private func isValidDomainPart(_ email: String) -> Bool {
        let domainPartPredicate = NSPredicate(
            format: Constants.formatString,
            Constants.domainPartRegex
        )

        return domainPartPredicate.evaluate(with: getEmailDomainPart(email))
    }

    private func isValidTopLevelDomain(_ email: String) -> Bool {
        let topLevelDomainPredicate = NSPredicate(
            format: Constants.formatString,
            Constants.topLevelDomainRegex
        )

        return topLevelDomainPredicate.evaluate(with: getEmailTopLevelDomain(email))
    }
}
