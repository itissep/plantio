import Foundation
import Core
import Models
import PUI // TODO: remove this later

struct PlantCollectionViewState: Equatable {
    // TODO: add frinds
    
    var plants: [Plant] = []
    var selectedPlant: Plant? = nil
    var plantEvents: [EventTimetableViewModel] = []
    var plantPhotos: [String] = []
    var plantPhotos: [PhotoModel] = []
    
    // Service
    var isLoading = false
    var isAlertPresenting = false
    var errorMessage: String = ""
}

enum PlantCollectionViewEvent {
    case onAppear
    case onAlertPresented(Bool)
    
    case onAddPlantTapped
    case onAddPhoto(Data?)
    case onDeletePlantTapped
    
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
            state.isLoading = true
            updatePlants()
            state.isLoading = false
        case .onAlertPresented(let errorMessage):
            print("[ERROR] \(errorMessage)")
        case .onAddPhoto(let imageData):
            addPhoto(imageData)
        case .onDeletePlantTapped:
            deleteSelectedPlant()
        case .onAddPlantTapped:
            coordinator.showCreatePlantScene()
        case .onPlantSelectWithId(let selectedId):
            state.isLoading = true
            state.selectedPlant = state.plants.first(where: { $0.id == selectedId})
            updateEvents(for: selectedId)
            updatePhotos(for: selectedId)
            state.isLoading = false
        }
    }
    
    private func addPhoto(_ imageData: Data?) {
        guard let imageData, let plantId = state.selectedPlant?.id else {
            return
        }
        plantService.newPhoto(imageData, for: plantId) { [weak self] error in
            if let error {
                self?.state.errorMessage = error.localizedDescription
            } else {
                self?.updatePhotos(for: plantId)
            }
        }
        
    }
    
    private func deleteSelectedPlant() {
        guard let plantId = state.selectedPlant?.id else {
            return
        }
        plantService.deletePlant(with: plantId) { [weak self] error in
            guard let error else {
                self?.updatePlants()
                return
            }
            print("[ERROR] \(error)")
            self?.state.errorMessage = error.localizedDescription
        }
    }
    
    private func updatePlants() {
        plantService.fetchPlants { [weak self] plants, error in
            self?.state.plants = plants
        }
    }
    
    private func updateEvents(for plantId: String) {
        plantService.getEvents(for: plantId) { [weak self] events, error in
            guard let self else {
                return
            }
            
            let weeks: [WeekModel] = splitDatesIntoWeeks(dates: generateDates().reversed()).map { week in
                WeekModel(days: week.map { date in
                    DayModel(
                        date: date,
                        isWatered: events.contains(where: { Date.isOneDay($0.createdAt, secondDate: date) })
                    )
                })
            }
            state.plantEvents = [.init(
                color: .pui.accent,
                title: "watering",
                weeks: weeks,
                actionTitle: "water me",
                onActionTap: { [weak self] in
                    self?.createNewEvent()
                }
            )]
        }
    }
    
    private func updatePhotos(for plantId: String) {
        plantService.getPhotos(for: plantId) { [weak self] photos, error in
            self?.state.plantPhotos = photos
        }
    }
    
    private func createNewEvent() {
        if let plant = state.selectedPlant {
            let newEvent = Models.Event(id: UUID().uuidString, note: "", plantId: plant.id, createdAt: .now)
            plantService.newEvent(newEvent) { [weak self] error in
                if let error {
                    self?.state.errorMessage = error.localizedDescription
                }
            }
        }
    }
}

private extension PlantCollectionViewModel {
    func generateDates(forLastDays: Int = 365) -> [Date] {
        var dates: [Date] = []
        let calendar = Calendar.current
        
        let now = Date()
        var date = now
        
        for _ in 1...forLastDays {
            dates.append(date)
            
            guard let newDate = calendar.date(byAdding: .day, value: -1, to: date) else { break }
            date = newDate
        }
        
        return dates.reversed()
    }

    func splitDatesIntoWeeks(dates: [Date]) -> [[Date]] {
        var weeks: [[Date]] = []
        let calendar = Calendar.current
        
        var currentWeek: [Date] = []
        var currentWeekStart: Date?
        
        for date in dates {
            // Определяем начало недели для текущей даты
            var components = calendar.dateComponents([.year, .weekOfYear], from: date)
            components.weekday = 1 // Понедельник
            if let weekStart = calendar.date(from: components) {
                if currentWeekStart == nil || weekStart != currentWeekStart {
                    // Если это начало новой недели, добавляем предыдущую неделю в результат
                    if !currentWeek.isEmpty {
                        weeks.append(currentWeek)
                    }
                    currentWeek = []
                    currentWeekStart = weekStart
                }
            }
            
            currentWeek.append(date)
        }
        
        // Добавляем последнюю неделю в результат
        if !currentWeek.isEmpty {
            weeks.append(currentWeek)
        }
        
        return weeks
    }

}
