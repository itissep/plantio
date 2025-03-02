import Core
import AuthModule
import PlantsModule
import ProfileModule
import FeedModule
import PlantClassifierModule
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        FirebaseSetup.configure()
        return true
    }
}

@main
struct PLANTIOApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    private let serviceLocator: ServiceLocator
    
    init() {
        let appServiceLocator = AppServiceLocator()
        
        appServiceLocator.register(MockAuthService() as AuthServiceProtocol)
        appServiceLocator.register(MockProfileService() as ProfileServiceProtocol)
//        appServiceLocator.register(MockPlantService() as PlantServiceProtocol)
        appServiceLocator.register(MockFeedService() as FeedServiceProtocol)
        appServiceLocator.register(RegistrationValidationService())
        appServiceLocator.register(ClassifierViewModel()) // TODO: separate ViewModel and Service later
        
        appServiceLocator.register(LocalPlantService() as PlantServiceProtocol)
        
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
