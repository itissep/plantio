import Foundation
import Models

public protocol PlantServiceProtocol {
    func createPlant(_ plant: Plant, completion: (Error?) -> Void)
    func fetchPlants(completion: @escaping ([Plant], Error?) -> Void)
    func getEvents(for plantId: String, completion: @escaping ([Event], Error?) -> Void)
    func getPhotos(for plantId: String, completion: @escaping ([String], Error?) -> Void)
    func newEvent(_ event: Event, completion: (Error?) -> Void)
}
