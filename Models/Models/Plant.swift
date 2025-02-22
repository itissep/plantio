import Foundation

public struct Plant: PlantlyModel, Equatable {
    public let id: String
    public let name: String
    public let mainImageUrl: String?
    public let createdDate: Date
    public let plantDate: Date?
    public let description: String?
    
    public init(
        id: String = UUID().uuidString,
        name: String,
        mainImageUrl: String? = nil,
        createdDate: Date = .now,
        plantDate: Date? = nil,
        description: String? = nil
    ) {
        self.id = id
        self.name = name
        self.mainImageUrl = mainImageUrl
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
            mainImageUrl: "https://i.pinimg.com/originals/fe/f8/7e/fef87efc5f2f87435fa3015dacff97c8.jpg",
            createdDate: .now,
            plantDate: .now,
            description: "beautiful one"
        )
    }
}
