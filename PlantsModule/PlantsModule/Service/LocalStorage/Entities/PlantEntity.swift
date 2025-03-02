import Foundation
import SwiftData
import Models

@Model
class PlantEntity {
    
    @Attribute(.unique) var id: UUID
    var name: String
    var mainImage: String?
    var createdAt: Date
    var plantDescription: String?
    
    init(
        id: UUID,
        name: String,
        mainImage: String? = nil,
        createdAt: Date,
        plantDescription: String? = nil
    ) {
        self.id = id
        self.name = name
        self.mainImage = mainImage
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
            mainImageUrl: self.mainImage,
            createdDate: self.createdAt,
            plantDate: nil,
            description: self.plantDescription
        )
    }
    
    static func from(_ model: Plant) -> PlantEntity {
        PlantEntity(
            id: UUID(uuidString: model.id)!,
            name: model.name,
            mainImage: model.mainImageUrl,
            createdAt: model.createdDate,
            plantDescription: model.description
        )
    }
}
