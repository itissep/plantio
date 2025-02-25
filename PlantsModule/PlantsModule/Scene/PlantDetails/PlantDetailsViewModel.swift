import Foundation
import Core
import Models

struct PlantDetailsViewState: Equatable {
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

enum PlantDetailsViewEvent {
    case onAppear
    case onAlertPresented(Bool)
    
    case onEditPlantsTapped
    case onAddPlantTapped
    
    case onPlantSelectWithId(String)
}


final class PlantDetailsViewModel: ViewModel {
    
    @Published private(set) var state: PlantDetailsViewState

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

    func handle(_ event: PlantDetailsViewEvent) {
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
        }
    }
}
