import Foundation
import Core

public class PlantCoordinator: Coordinator {

    public enum Screen: Routable {
        case plantCollection
        case plant(String)
//        case sharePlant
    }

    @Published public var navigationPath = [Screen]()

    public init() { }
}

extension PlantCoordinator: PlantCoordinatorProtocol {
    public func showPlantCollectionScene() {
        navigationPath.append(.plantCollection)
    }
    
    public func showPlantDetailsScene(with id: String) {
        navigationPath.append(.plant(id))
    }
    
    public func showSharePlantScene() {
        print("going to show sharing")
    }
}
