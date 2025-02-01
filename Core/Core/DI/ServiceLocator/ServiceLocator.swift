import Foundation

public protocol ServiceLocator {
    func resolve<T>() -> T?
}
