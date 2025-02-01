import Foundation

public protocol PlantlyModel: Identifiable & Codable {
    var id: String { get }
}
