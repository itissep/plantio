import SwiftUI

public struct PlantCoordinatorView: View {

    private let factory: PlantViewFactory
    @ObservedObject private var coordinator: PlantCoordinator
    
    public init(_ coordinator: PlantCoordinator, factory: PlantViewFactory) {
        self.factory = factory
        self.coordinator = coordinator
    }
    
    public var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            factory.makePlantCollectionView(coordinator: coordinator)
                .navigationDestination(for: PlantCoordinator.Screen.self) {
                    destination($0)
                }
        }
    }
    
    @ViewBuilder
    private func destination(_ screen: PlantCoordinator.Screen) -> some View {
        switch screen {
        case .plantCollection:
            factory.makePlantCollectionView(coordinator: coordinator)
        case .createPlant:
            factory.makeCreatePlantView(coordinator: coordinator)
        }
    }
}
