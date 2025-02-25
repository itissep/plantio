import Foundation

public struct Event {
    public let id: String
    public let note: String?
    public let plant: Plant
    public let createdAt: Date
    
    
    public init(
        id: String,
        note: String?,
        plant: Plant,
        createdAt: Date
    ) {
        self.id = id
        self.note = note
        self.plant = plant
        self.createdAt = createdAt
    }
}

public extension Event {
    static var mock: Event {
        .init(id: UUID().uuidString, note: "some note", plant: Plant.mock, createdAt: .now)
    }
}
