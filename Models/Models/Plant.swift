import Foundation

public struct Plant: Codable {
    let id: String
    let name: String
    let mainImageUrl: String?
    let createdDate: Date
    let plantDate: Date?
    let description: String?
}
