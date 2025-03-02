import Foundation

public struct Plant: PlantlyModel, Equatable {
    public let id: String
    public let name: String
    public let imageData: Data?
    public let createdDate: Date
    public let plantDate: Date?
    public let description: String?
    
    public init(
        id: String = UUID().uuidString,
        name: String,
        imageData: Data? = nil,
        createdDate: Date = .now,
        plantDate: Date? = nil,
        description: String? = nil
    ) {
        self.id = id
        self.name = name
        self.imageData = imageData
        self.createdDate = createdDate
        self.plantDate = plantDate
        self.description = description
    }
}

public extension Plant {
    static var mock: Plant {
        .init(
            id: UUID().uuidString,
            name: "some plant",
            imageData: nil,
            createdDate: .now,
            plantDate: .now,
            description: "beautiful one"
        )
    }
}
