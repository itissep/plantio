import SwiftUI
import Core
import AuthModule
import ProfileModule

@main
struct PlantlyApp: App {
    private let serviceLocator: ServiceLocator
    
    init() {
        let appServiceLocator = AppServiceLocator()
        
        appServiceLocator.register(MockAuthService() as AuthServiceProtocol)
        appServiceLocator.register(MockProfileService() as ProfileServiceProtocol)
        appServiceLocator.register(RegistrationValidationService())
        
        self.serviceLocator = appServiceLocator
    }
    
    var body: some Scene {
        WindowGroup {
            AppCoordinatorView(
                screenFactory: ScreenFactory(serviceLocator: serviceLocator),
                coordinator: AppCoordinator(profileService: serviceLocator.resolve()!)
            )
            .preferredColorScheme(.light)
        }
    }
}
