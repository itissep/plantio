import SwiftUI

@MainActor
public protocol PlantViewFactory {
    func makePlantCollectionView(coordinator: PlantCoordinatorProtocol) -> PlantCollectionView
    func makePlantView(coordinator: PlantCoordinatorProtocol, plantId: String) -> PlantDetailsView
}
