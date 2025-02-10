import Foundation

public final class ScreenFactory {

    public let serviceLocator: ServiceLocator

    public init(serviceLocator: ServiceLocator) {
        self.serviceLocator = serviceLocator
    }
}
