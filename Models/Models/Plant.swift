import Foundation

public struct Plant: PlantlyModel {
    public let id: String
    let name: String
    let mainImageUrl: String?
    let createdDate: Date
    let plantDate: Date?
    let description: String?
    
    public init() {
        self.id = UUID().uuidString
        self.name = "name"
        self.mainImageUrl = nil
        self.createdDate = .now
        self.plantDate = .now
        self.description = "description"
    }
}
