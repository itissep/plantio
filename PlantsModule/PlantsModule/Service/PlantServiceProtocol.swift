import Foundation
import Models

public protocol PlantServiceProtocol {
    func createPlant(_ plant: Plant, completion: (Error?) -> Void)
    func fetchPlants() -> [Plant]
    func getEvents() -> [Event]
    func newEvent(_ event: Event, completion: (Error?) -> Void)
}
