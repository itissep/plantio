import Foundation
import ProfileModule

@MainActor
final class AppCoordinator: ObservableObject {

    enum State {
        case idle
        case loading
        case auth
        case main
    }

    enum Action {
        case showAuth
        case showMain
        case checkAuthorization
    }

    @Published private(set) var state: State
    
    private let profileService: ProfileServiceProtocol

    init(profileService: ProfileServiceProtocol) {
        self.state = .idle
        self.profileService = profileService
    }

    func handle(_ action: Action) {
        switch action {
        case .checkAuthorization:
            Task { await loadData() }
        case .showAuth:
            state = .auth
        case .showMain:
            state = .main
        }
    }
}

private extension AppCoordinator {

    func loadData() async {
        state = .loading

        do {
#warning("TODO: find a way to get rid of this")
            try await _ = profileService.getProfile()
            state = .main
        } catch {
            state = .auth
        }
    }
}
