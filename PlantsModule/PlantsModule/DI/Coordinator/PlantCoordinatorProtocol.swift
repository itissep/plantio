import Foundation

@MainActor
public protocol PlantCoordinatorProtocol {
    func showPlantCollectionScene()
    func showPlantDetailsScene(with id: String)
}
