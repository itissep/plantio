import Foundation
import Models
import Core
import SwiftData

@MainActor
public class LocalPlantService: @preconcurrency PlantServiceProtocol {

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            PlantEntity.self,
            EventEntity.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    public init() {
        
    }
    
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
    
    
    @MainActor public func deletePlant(with plantId: String, completion: @escaping ((any Error)?) -> Void) {
        do {
            try sharedModelContainer.mainContext.delete(
                model: PlantEntity.self,
                where: #Predicate { plant in plant.id.uuidString == plantId }
            )
            completion(nil)
        } catch {
            completion(error)
        }
    }
    
    @MainActor public func deleteEvent(with eventId: String, completion: @escaping ((any Error)?) -> Void) {
        do {
            try sharedModelContainer.mainContext.delete(
                model: EventEntity.self,
                where: #Predicate { event in event.id.uuidString == eventId }
            )
            completion(nil)
        } catch {
            completion(error)
        }
    }
    
    
    @MainActor public func getEvents(for plantId: String, completion: @escaping ([Models.Event], (any Error)?) -> Void) {
        do {
            let models = try sharedModelContainer.mainContext.fetch(FetchDescriptor<EventEntity>())
                .filter { $0.plantId == plantId }
                .map { $0.toModel() }
            completion(models, nil)
        } catch {
            completion([], error)
        }
    }
    
    @MainActor public func getPhotos(for plantId: String, completion: @escaping ([String], (any Error)?) -> Void) {
        //
    }
    
    
    @MainActor public func newEvent(_ event: Models.Event, completion: @escaping ((any Error)?) -> Void) {
        do {
            let entity = EventEntity.from(event)
            sharedModelContainer.mainContext.insert(entity)
            try sharedModelContainer.mainContext.save()
            completion(nil)
        } catch {
            completion(error)
        }
    }
    
    @MainActor public func deletePhoto(with path: String, completion: @escaping ((any Error)?) -> Void) {
        //
    }
}
