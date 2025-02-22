import Foundation
import Core

public final class ClassifierCoordinator: Coordinator {

    public enum Screen: Routable {
        case classifier
    }

    @Published public var navigationPath = [Screen]()

    public init() { }
}

extension ClassifierCoordinator: ClassifierCoordinatorProtocol {
    public func showClassifierScene() {
        navigationPath.append(.classifier)
    }
}
