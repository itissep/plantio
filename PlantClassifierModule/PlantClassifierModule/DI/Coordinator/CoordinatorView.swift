import SwiftUI

public struct ClassifierCoordinatorView: View {

    private let factory: ClassifierViewFactory
    @ObservedObject private var coordinator: ClassifierCoordinator
    
    public init(_ coordinator: ClassifierCoordinator, factory: ClassifierViewFactory) {
        self.factory = factory
        self.coordinator = coordinator
    }
    
    public var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            factory.makeClassifierView(coordinator: coordinator)
                .navigationDestination(for: ClassifierCoordinator.Screen.self) {
                    destination($0)
                }
        }
    }
    
    @ViewBuilder
    private func destination(_ screen: ClassifierCoordinator.Screen) -> some View {
        switch screen {
        case .classifier:
            factory.makeClassifierView(coordinator: coordinator)
        }
    }
}
