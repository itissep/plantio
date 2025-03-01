import Foundation
import Core

extension ScreenFactory: PlantViewFactory {
    
    @MainActor
    public func makePlantCollectionView(coordinator: PlantCoordinatorProtocol) -> PlantCollectionView {
        let viewModel = PlantCollectionViewModel(coordinator: coordinator, plantService: serviceLocator.resolve()!)
        return PlantCollectionView(viewModel: viewModel)
    }
    
    public func makePlantView(coordinator: PlantCoordinatorProtocol, plantId: String) -> PlantDetailsView {
//        let viewModel = PostDetailsViewModel(
//            coordinator: coordinator,
//            feedService: serviceLocator.resolve()!,
//            postId: postId
//        )
        return PlantDetailsView()
    }
}
