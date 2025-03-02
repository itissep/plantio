import Foundation
import Core

extension ScreenFactory: PlantViewFactory {
    
    @MainActor
    public func makePlantCollectionView(coordinator: PlantCoordinatorProtocol) -> PlantCollectionView {
        let viewModel = PlantCollectionViewModel(coordinator: coordinator, plantService: serviceLocator.resolve()!)
        return PlantCollectionView(viewModel: viewModel)
    }
    
    @MainActor
    public func makeCreatePlantView(coordinator: PlantCoordinatorProtocol) -> CreatePlantView {
        let viewModel = CreatePlantViewModel(
            coordinator: coordinator,
            plantService: serviceLocator.resolve()!
        )
        return CreatePlantView(viewModel: viewModel)
    }
}
