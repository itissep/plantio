import Foundation
import Core
import Models

struct PlantCollectionViewState: Equatable {
    // TODO: add plants
    var plants: [Plant] = [
        .init(name: "some plant"), .init(name: "some plant"), .init(name: "some plant"), .init(name: "some plant"),
    ]
    // TODO: add frinds
    
    // Service
    var isLoading = false
    var isAlertPresenting = false
    var errorMessage: String = ""
}

enum PlantCollectionViewEvent {
    case onAppear
    case onAlertPresented(Bool)
    
    case onEditPlantsTapped
    case onAddPlantTapped
    
    case onPlantSelectWithId(String)
}


final class PlantCollectionViewModel: ViewModel {
    
    @Published private(set) var state: PlantCollectionViewState

    private let coordinator: PlantCoordinatorProtocol
    private let plantService: PlantServiceProtocol

    init(
        coordinator: PlantCoordinatorProtocol,
        plantService: PlantServiceProtocol
    ) {
        self.state = .init()
        self.coordinator = coordinator
        self.plantService = plantService
    }

    func handle(_ event: PlantCollectionViewEvent) {
        switch event {
        case .onAppear:
//            Task { await retrieveProfile() }
            print("wow")
        case .onAlertPresented(_):
            print("wow")
        case .onAddPlantTapped:
            print("wow")
        case .onPlantSelectWithId(_):
            print("wow")
        case .onEditPlantsTapped:
            print("wow")
            //
        }
    }
}

private extension PlantCollectionViewModel {

//    func handleError(_ error: Error) {
//        if error as? AuthError == .unauthorized {
//            coordinator.showAuthScene()
//        } else {
//            state.errorMessage = error.localizedDescription
//            state.isAlertPresenting = true
//        }
//    }
//
//    func retrieveProfile() async {
//        state.isLoading = true
//        do {
//            let profile = try await profileService.getProfile()
//            self.profile = profile
//            
//            self.state.avatarLink = profile.avatarUrl ?? ""
//            self.state.name = profile.name
//            self.state.description = profile.description ?? "no descriptions"
//            state.isLoading = false
//        } catch {
//            state.errorMessage = error.localizedDescription
//            state.isLoading = false
//        }
//    }
}
