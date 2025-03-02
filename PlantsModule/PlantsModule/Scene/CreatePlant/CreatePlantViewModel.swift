import Foundation
import Core
import Models

class CreatePlantViewModel: ViewModel {
    
    
    @Published private(set) var state: CreatePlantViewState

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
    
    func handle(_ event: CreatePlantViewEvent) {
        switch event {
        case .onAppear:
//            Task { await retrieveProfile() }
            break
        case .saveTapped:
            Task { await createPlant() }
        case .cancelTapped:
            coordinator.showPlantCollectionScene()

        case .imageChanged(let imageData):
//            avatarLinkUpdated(imageData)
            break
        case .nameChanged(let name):
            state.name = name
            
            
        case .onAlertPresented(let isPresented):
            state.isAlertPresenting = isPresented
            
        case .descriptionChanged(let description):
            state.description = description
        }
        
//        checkDataIsChange()
    }
}

private extension CreatePlantViewModel {
    
    func handleError(_ error: Error) {
        state.errorMessage = error.localizedDescription
        state.isAlertPresenting = true
    }
    
    func createPlant() async {
        plantService.createPlant(
            Plant(
                id: UUID().uuidString,
                name: state.name,
                mainImageUrl: nil, // TODO: safe image
                createdDate: .now,
                plantDate: nil,
                description: state.description
            )) { [weak self] error in
                if let error {
                    print(error.localizedDescription)
                }
                self?.coordinator.showPlantCollectionScene()
            }
    }

}
