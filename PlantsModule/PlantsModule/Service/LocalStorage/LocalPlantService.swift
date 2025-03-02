import Foundation
import Models
import Core
import SwiftData

public struct PhotoModel: Equatable {
    let id: String
    let plantId: String
    let imageData: Data
    let createdAt: Date
    
    static func from(_ entity: PhotoEntity) -> PhotoModel {
        .init(
            id: entity.id.uuidString,
            plantId: entity.plantId,
            imageData: entity.imageData,
            createdAt: entity.createdAt
        )
    }
    
    func toEntity() -> PhotoEntity {
        .init(
            id: UUID(uuidString: id)!,
            plantId: plantId,
            imageData: imageData,
            createdAt: createdAt
        )
    }
}

@MainActor
public class LocalPlantService: @preconcurrency PlantServiceProtocol {

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            PlantEntity.self,
            EventEntity.self,
            PhotoEntity.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    public init() { }
    
    @MainActor public func createPlant(_ plant: Models.Plant, completion: ((any Error)?) -> Void) {
        do {
            let entity = PlantEntity.from(plant)
            sharedModelContainer.mainContext.insert(entity)
            try sharedModelContainer.mainContext.save()
            completion(nil)
        } catch {
            completion(error)
        }
    }
    
    public func fetchPlants(completion: @escaping ([Models.Plant], (any Error)?) -> Void) {
        do {
            let models = try sharedModelContainer.mainContext.fetch(FetchDescriptor<PlantEntity>())
                .map { $0.toModel() }
            print("fetched plants:", models.count)
            completion(models, nil)
        } catch {
            completion([], error)
        }
    }
    
    public func deletePlant(with plantId: String, completion: @escaping ((any Error)?) -> Void) {
        do {
            let uuid = UUID(uuidString: plantId)!
            try sharedModelContainer.mainContext.delete(
                model: PlantEntity.self,
                where: #Predicate { plant in plant.id == uuid }
            )
            completion(nil)
        } catch {
            completion(error)
        }
    }
    
    public func deleteEvent(with eventId: String, completion: @escaping ((any Error)?) -> Void) {
        do {
            let uuid = UUID(uuidString: eventId)!
            try sharedModelContainer.mainContext.delete(
                model: EventEntity.self,
                where: #Predicate { event in event.id == uuid }
            )
            completion(nil)
        } catch {
            completion(error)
        }
    }
    
    public func getEvents(for plantId: String, completion: @escaping ([Models.Event], (any Error)?) -> Void) {
        do {
            let models = try sharedModelContainer.mainContext.fetch(FetchDescriptor<EventEntity>())
                .filter { $0.plantId == plantId }
                .map { $0.toModel() }
            print("fetched events:", models.count, models)
            completion(models, nil)
        } catch {
            completion([], error)
        }
    }
    
    public func getPhotos(for plantId: String, completion: @escaping ([PhotoModel], (any Error)?) -> Void) {
        do {
            let models = try sharedModelContainer.mainContext.fetch(FetchDescriptor<PhotoEntity>())
                .filter { $0.plantId == plantId }
                .map { PhotoModel.from($0) }
            print("fetched events:", models.count, models)
            completion(models, nil)
        } catch {
            completion([], error)
        }
    }
    
    public func newPhoto(_ imageData: Data, for plantId: String, completion: @escaping ((any Error)?) -> Void) {
        do {
            let entity = PhotoEntity(id: UUID(), plantId: plantId, imageData: imageData, createdAt: .now)
            sharedModelContainer.mainContext.insert(entity)
            try sharedModelContainer.mainContext.save()
            completion(nil)
        } catch {
            completion(error)
        }
    }
    
    
    
    public func newEvent(_ event: Models.Event, completion: @escaping ((any Error)?) -> Void) {
        do {
            let entity = EventEntity.from(event)
            sharedModelContainer.mainContext.insert(entity)
            try sharedModelContainer.mainContext.save()
            completion(nil)
        } catch {
            completion(error)
        }
    }
    
    public func deletePhoto(with id: String, completion: @escaping ((any Error)?) -> Void) {
        do {
            let uuid = UUID(uuidString: id)!
            try sharedModelContainer.mainContext.delete(
                model: PhotoEntity.self,
                where: #Predicate { photo in photo.id == uuid }
            )
            completion(nil)
        } catch {
            completion(error)
        }
    }
}
