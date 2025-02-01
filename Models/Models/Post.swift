import Foundation

public struct Post: PlantlyModel {
    public let id: String
    let plantId: String // or just plant?
    let date: Date
    let imagesUrls: [String]
    let description: String?
}
