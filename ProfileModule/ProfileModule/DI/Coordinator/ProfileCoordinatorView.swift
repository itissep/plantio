import SwiftUI

public struct ProfileCoordinatorView: View {

    private let factory: ProfileViewFactory
    @ObservedObject private var coordinator: ProfileCoordinator
    
    public init(_ coordinator: ProfileCoordinator, factory: ProfileViewFactory) {
        self.factory = factory
        self.coordinator = coordinator
    }
    
    public var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            factory.makeProfileView(coordinator: coordinator)
                .navigationDestination(for: ProfileCoordinator.Screen.self) {
                    destination($0)
                }
        }
    }
    
    @ViewBuilder
    private func destination(_ screen: ProfileCoordinator.Screen) -> some View {
        switch screen {
        case .profile:
            factory.makeProfileView(coordinator: coordinator)
        case .editProfile:
            factory.makeEditProfileView(coordinator: coordinator)
//        case .shareProfile:
////            Text("sharing")
        }
    }
}
