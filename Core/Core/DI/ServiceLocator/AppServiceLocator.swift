import Foundation

public class AppServiceLocator: ServiceLocator {
    private var services: [String: Any] = [:]
    
    public init() { }

    public func register<T>(_ service: T) {
        let key = String(describing: T.self)
        services[key] = service
    }

    public func resolve<T>() -> T? {
        let key = String(describing: T.self)
        return services[key] as? T
    }
}
