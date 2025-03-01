import Foundation
import Models
import Core

public class MockPlantService: PlantServiceProtocol {
    
    public init() { }
    
    public func createPlant(_ plant: Plant, completion: ((any Error)?) -> Void) {
        completion(nil)
    }
    
    public func getEvents(for plantId: String, completion: @escaping ([Event], (any Error)?) -> Void) {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion(
                [
                    .init(
                        id: "1",
                        note: "",
                        plant: Plant.mock,
                        createdAt: Date(day: 27, month: 1, year: 2025)!
                    ),
                    .init(
                        id: "3",
                        note: "",
                        plant: Plant.mock,
                        createdAt: Date(day: 26, month: 1, year: 2025)!
                    ),
                    .init(
                        id: "2",
                        note: "",
                        plant: Plant.mock,
                        createdAt: Date(day: 25, month: 1, year: 2025)!
                    )
                ], nil)
//        }
    }
    
    public func getPhotos(completion: @escaping ([String], (any Error)?) -> Void) {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion([
                "https://thumbs.dreamstime.com/b/orchid-flower-pink-branch-65923208.jpg",
                "https://thumbs.dreamstime.com/b/orchid-flower-pink-branch-65923208.jpg",
                "https://thumbs.dreamstime.com/b/orchid-flower-pink-branch-65923208.jpg",
            ], nil)
//        }
    }
    
    public func getPhotos(for plantId: String, completion: @escaping ([String], (any Error)?) -> Void) {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion([
                "https://thumbs.dreamstime.com/b/orchid-flower-pink-branch-65923208.jpg",
                "https://otvet.imgsmail.ru/download/9758d43be280f549fb4b747f42b67888_h-683.jpg",
                "https://orchidsqueen.ru/wa-data/public/shop/products/22/14/1422/images/9319/9319.970.jpg",
            ], nil)
//        }
    }
    
    public func fetchPlants(completion: @escaping ([Plant], (any Error)?) -> Void) {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion([
                .init(name: "some plant", mainImageUrl: "https://thumbs.dreamstime.com/b/orchid-flower-pink-branch-65923208.jpg"),
                .init(name: "some plant", mainImageUrl: "https://thumbs.dreamstime.com/b/orchid-flower-pink-branch-65923208.jpg"),
                .init(name: "some plant", mainImageUrl: "https://thumbs.dreamstime.com/b/orchid-flower-pink-branch-65923208.jpg"),
            ], nil)
//        }
    }
    
    public func newEvent(_ event: Event, completion: ((any Error)?) -> Void) {
        print("eventCreated")
        completion(nil)
    }
}
