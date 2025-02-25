import Foundation
import Models

public class MockPlantService: PlantServiceProtocol {
    
    public init() { }
    
    public func createPlant(_ plant: Plant, completion: ((any Error)?) -> Void) {
        completion(nil)
    }
    
    public func fetchPlants() -> [Plant] {
        [.mock, .mock, .mock]
    }
    
    public func getEvents() -> [Event] {
        [
            .init(
                id: "1",
                note: "",
                plant: Plant.mock,
                createdAt: .now.addingTimeInterval(-300)
            ),
            .init(
                id: "3",
                note: "",
                plant: Plant.mock,
                createdAt: .now.addingTimeInterval(-900)
            ),
            .init(
                id: "2",
                note: "",
                plant: Plant.mock,
                createdAt: .now.addingTimeInterval(-600)
            )
        ]
    }
    
    public func newEvent(_ event: Event, completion: ((any Error)?) -> Void) {
        print("eventCreated")
        completion(nil)
    }
}
