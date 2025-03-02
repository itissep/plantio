import Foundation
import SwiftData
import Models

@Model
class EventEntity {
    
    @Attribute(.unique) var id: UUID
    var note: String?
    var plantId: String
    var createdAt: Date
    
    init(
        id: UUID,
        note: String?,
        plantId: String,
        createdAt: Date
    ) {
        self.id = id
        self.note = note
        self.plantId = plantId
        self.createdAt = createdAt
    }
}

extension EventEntity: Identifiable { }

extension EventEntity {
    func toModel() -> Event {
        Event(
            id: self.id.uuidString,
            note: self.note,
            plantId: self.plantId,
            createdAt: self.createdAt
        )
    }
    
    static func from(_ model: Event) -> EventEntity {
        EventEntity(
            id: UUID(uuidString: model.id)!,
            note: model.note,
            plantId: model.plantId,
            createdAt: model.createdAt
        )
    }
}
