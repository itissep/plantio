import Foundation
import Core

public class PlantCoordinator: Coordinator {

    public enum Screen: Routable {
        case plantCollection
        case createPlant
//        case sharePlant
    }

    @Published public var navigationPath = [Screen]()

    public init() { }
}

extension PlantCoordinator: PlantCoordinatorProtocol {
    public func showPlantCollectionScene() {
        if navigationPath.last == .createPlant {
            navigationPath.remove(at: navigationPath.count - 1)
        } else {
            navigationPath.append(.plantCollection)
        }
    }
    
    public func showCreatePlantScene() {
        navigationPath.append(.createPlant)
    }
    
    public func showSharePlantScene() {
        print("going to show sharing")
    }
}
