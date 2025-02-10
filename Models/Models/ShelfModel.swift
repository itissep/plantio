import Foundation

public struct Shelf: PlantlyModel {
    public let id: String
    let name: String
    let createdDate: Date
    let description: String?
    let plants: [Plant]
    
    public init(plants: [Plant]) {
        self.id = UUID().uuidString
        self.name = "name"
        self.createdDate = .now
        self.description = "description"
        self.plants = plants
    }
}
