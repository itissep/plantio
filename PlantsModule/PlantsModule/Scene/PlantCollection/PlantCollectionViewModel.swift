import Foundation
import Core
import Models


// Модель данных для графика



extension Date {
    init?(day: Int, month: Int, year: Int) {
        var components = DateComponents()
        components.day = day
        components.month = month
        components.year = year
        
        guard let date = Calendar.current.date(from: components) else {
            return nil
        }
        
        self = date
    }
    
    static func date(day: Int, month: Int, year: Int) -> Date? {
        var components = DateComponents()
        components.day = day
        components.month = month
        components.year = year
        
        return Calendar.current.date(from: components)
    }
    
    func isMonday() -> Bool {
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: self)
        
        // В Gregorian календаре понедельник — это 2, если неделя начинается с воскресенья.
        return weekday == 2
    }
}

// Функция для генерации массива дат
func generateDates(forLastDays: Int = 365) -> [Date] {
    var dates: [Date] = []
    let calendar = Calendar.current
    
    let now = Date()
    var date = now
    
    // Генерируем даты за последние 365 дней
    for _ in 1...forLastDays {
        dates.append(date)
        
        // Переходим к предыдущему дню
        guard let newDate = calendar.date(byAdding: .day, value: -1, to: date) else { break }
        date = newDate
    }
    
    return dates.reversed()
}

// Функция для разбиения дат на недели
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

// Генерируем и разбиваем даты на недели
let dates = generateDates()
let weeks = splitDatesIntoWeeks(dates: dates)


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
