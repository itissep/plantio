import Foundation
import Models

public protocol PlantServiceProtocol {
    func fetchPlants(completion: @escaping ([Plant], Error?) -> Void)
    func createPlant(_ plant: Plant, completion: @escaping (Error?) -> Void)
    func deletePlant(with plantId: String, completion: @escaping (Error?) -> Void)
    
    func getEvents(for plantId: String, completion: @escaping ([Event], Error?) -> Void)
    func newEvent(_ event: Event, completion: @escaping (Error?) -> Void)
    func deleteEvent(with eventId: String, completion: @escaping (Error?) -> Void)
    
    func deletePhoto(with id: String, completion: @escaping (Error?) -> Void)
    func newPhoto(_ imageData: Data, for plantId: String, completion: @escaping (Error?) -> Void)
    func getPhotos(for plantId: String, completion: @escaping ([PhotoModel], Error?) -> Void)
}
