import Foundation

public protocol Routable: Hashable, Identifiable {}

public extension Routable {
    var id: String {
        String(describing: self)
    }
}
