import SwiftUI

@MainActor
public protocol PlantViewFactory {
    func makePlantCollectionView(coordinator: PlantCoordinatorProtocol) -> PlantCollectionView
    func makeCreatePlantView(coordinator: PlantCoordinatorProtocol) -> CreatePlantView
}
