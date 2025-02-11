import Foundation
import Core
import Models
import AuthModule

final class ProfileViewModel: ViewModel {
    
    enum ProfileTab {
        case plants
        case friends
        
        var title: String {
            switch self {
            case .plants: "plants"
            case .friends: "Plants"
            }
        }
    }

    @Published private(set) var state: ProfileViewState
    @Published var selectedTab: ProfileTab = .plants

    private var profile: UserProfile?
    private let coordinator: ProfileCoordinatorProtocol
    private let profileService: ProfileServiceProtocol

    init(
        coordinator: ProfileCoordinatorProtocol,
        profileService: ProfileServiceProtocol
    ) {
        self.state = .init()
        self.coordinator = coordinator
        self.profileService = profileService
    }

    func handle(_ event: ProfileViewEvent) {
        switch event {
        case .onAppear:
            Task { await retrieveProfile() }
        case .onEditProfileTapped:
            coordinator.showEditProfileScene()
        case .onAddPlantTapped:
            print("wow")
        case .onAddFriendsTapped:
            print("wow")
        case .onShareButtonTapped:
            print("going to show share view")
        case .onSortTypeChanged:
            print("wow")
        case .onPlantSelectWithId(_):
            print("wow")
        case .onFriendSelectWithId(_):
            print("wow")
        case .onAlertPresented(_):
            print("wow")
        }
    }
}

private extension ProfileViewModel {

    func handleError(_ error: Error) {
        if error as? AuthError == .unauthorized {
            coordinator.showAuthScene()
        } else {
            state.errorMessage = error.localizedDescription
            state.isAlertPresenting = true
        }
    }

    func retrieveProfile() async {
        state.isLoading = true
        do {
            let profile = try await profileService.getProfile()
            self.profile = profile
            
            self.state.avatarLink = profile.avatarUrl ?? ""
            self.state.name = profile.name
            self.state.description = profile.description ?? "no descriptions"
            state.isLoading = false
        } catch {
            state.errorMessage = error.localizedDescription
            state.isLoading = false
        }
    }
}
