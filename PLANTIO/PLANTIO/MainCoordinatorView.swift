import SwiftUI
import Core
import PUI
import ProfileModule

struct MainCoordinatorView: View {

    enum Tab {
        case plants
        case feed
        case profile
        case identifier
        case settings
        
        var icon: String {
            switch self {
            case .plants: "leaf.fill"
            case .feed: "rectangle.stack.fill"
            case .profile: "person.fill"
            case .identifier: "sparkle.magnifyingglass"
            case .settings: "gear"
            }
        }
        
        var title: String {
            switch self {
            case .plants: "plants"
            case .feed: "feed"
            case .profile: "profile"
            case .identifier: "identifier"
            case .settings: "settings"
            }
        }
    }

    @State private var selectedTab = Tab.profile

    private let factory: ScreenFactory

    private let profileCoordinator: ProfileCoordinator
    
    // TODO: add Feed coordinator
    // TODO: add Plants coordinator
    // TODO: add Identifier coordinator
    // TODO: add Settings coordinator

    init(factory: ScreenFactory, showAuthSceneHandler: @escaping () -> Void) {
        self.factory = factory
        
        profileCoordinator = .init(showAuthSceneHandler: showAuthSceneHandler)
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            Text("Feed")
                .tabItem {
                    Label(Tab.feed.title, systemImage: Tab.feed.icon)
                }
                .tag(Tab.feed)
            
            Text("Plants")
                .tabItem {
                    Label(Tab.plants.title, systemImage: Tab.plants.icon)
                }
                .tag(Tab.plants)
            
            Text("Identifier")
                .tabItem {
                    Label(Tab.identifier.title, systemImage: Tab.identifier.icon)
                }
                .tag(Tab.identifier)
            
            ProfileCoordinatorView(profileCoordinator, factory: factory)
                .tabItem {
                    Label(Tab.profile.title, systemImage: Tab.profile.icon)
                }
                .tag(Tab.profile)
            
            Text("Settings")
                .tabItem {
                    Label(Tab.settings.title, systemImage: Tab.settings.icon)
                }
                .tag(Tab.settings)
        }
        .onAppear {
            setupTabBar()
        }
    }

    @MainActor private func setupTabBar() {
        UITabBar.appearance().tintColor = .accent
        UITabBar.appearance().isTranslucent = true

        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(.pui.backgroundSecondary)

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = UITabBar.appearance().standardAppearance
    }
}
