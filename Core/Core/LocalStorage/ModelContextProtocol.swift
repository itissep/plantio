import Foundation
import SwiftData

public protocol ModelContextProtocol {
    
    func fetch<T>(_ descriptor: FetchDescriptor<T>) throws -> [T]
    func insert<T>(_ model: T) where T: PersistentModel
    func deleteAll<T>(model: T.Type) throws where T: PersistentModel
    func save() throws
}

extension ModelContext: ModelContextProtocol {
    
    public func deleteAll<T: PersistentModel>(model: T.Type) throws {
        try self.delete(model: T.self)
    }
}
