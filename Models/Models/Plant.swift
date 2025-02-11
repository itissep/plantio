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
