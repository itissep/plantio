import Foundation
import SwiftData

@Model
class PhotoEntity {
    
    @Attribute(.unique) var id: UUID
    var plantId: String
    @Attribute(.externalStorage) var imageData: Data
    var createdAt: Date
    
    init(
        id: UUID,
        plantId: String,
        imageData: Data,
        createdAt: Date
    ) {
        self.id = id
        self.plantId = plantId
        self.imageData = imageData
        self.createdAt = createdAt
    }
}

extension PhotoEntity: Identifiable { }
