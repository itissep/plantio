import Foundation

public struct Event {
    public let id: String
    public let note: String?
    public let plantId: String
    public let createdAt: Date
    
    
    public init(
        id: String,
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

public extension Event {
    static var mock: Event {
        .init(id: UUID().uuidString, note: "some note", plantId: Plant.mock.id, createdAt: .now)
    }
}
