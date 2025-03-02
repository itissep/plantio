import Foundation
import SwiftData
import Models

@Model
class PlantEntity {
    
    @Attribute(.unique) var id: UUID
    var name: String
    
    @Attribute(.externalStorage) var imageData: Data?
    
    var createdAt: Date
    var plantDescription: String?
    
    init(
        id: UUID,
        name: String,
        imageData: Data? = nil,
        createdAt: Date,
        plantDescription: String? = nil
    ) {
        self.id = id
        self.name = name
        self.imageData = imageData
        self.createdAt = createdAt
        self.plantDescription = plantDescription
    }
}

extension PlantEntity: Identifiable { }

extension PlantEntity {
    func toModel() -> Plant {
        Plant(
            id: self.id.uuidString,
            name: self.name,
            imageData: self.imageData,
            createdDate: self.createdAt,
            plantDate: nil,
            description: self.plantDescription
        )
    }
    
    static func from(_ model: Plant) -> PlantEntity {
        PlantEntity(
            id: UUID(uuidString: model.id)!,
            name: model.name,
            imageData: model.imageData,
            createdAt: model.createdDate,
            plantDescription: model.description
        )
    }
}
