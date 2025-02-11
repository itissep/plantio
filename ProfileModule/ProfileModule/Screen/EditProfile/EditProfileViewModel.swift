import Foundation
import Models
import Core
import AuthModule

final class EditProfileViewModel: ViewModel {

    @Published private(set) var state: EditProfileViewState

    private var profile: UserProfile?
    private let coordinator: ProfileCoordinatorProtocol
    
    private let profileService: ProfileServiceProtocol
    private let validateServise: RegistrationValidationService

    init(
        coordinator: ProfileCoordinatorProtocol,
        profileService: ProfileServiceProtocol,
        validateServise: RegistrationValidationService
    ) {
        self.state = .init()
        self.coordinator = coordinator
        self.profileService = profileService
        self.validateServise = validateServise
    }

    func handle(_ event: EditProfileViewEvent) {
        switch event {
        case .onAppear:
            Task { await retrieveProfile() }

        case .saveTapped:
            Task { await updateProfile() }

        case .cancelTapped:
            resetChanges()

        case .emailChanged(let email):
            emailUpdated(email)

        case .avatarLinkChanged(let link):
            avatarLinkUpdated(link)

        case .nameChanged(let name):
            state.name = name
            
        case .usernameChanged(let username):
            usernameUpdated(username)

        case .onAlertPresented(let isPresented):
            state.isAlertPresenting = isPresented
            
        case .descriptionChanged(let description):
            state.description = description
        }

        checkDataIsChange()
    }
}

private extension EditProfileViewModel {

    func handleError(_ error: Error) {
        if error as? AuthError == .unauthorized {
            coordinator.showAuthScene()
        } else {
            state.errorMessage = error.localizedDescription
            state.isAlertPresenting = true
        }
    }

    func retrieveProfile() async {
        do {
            let profile = try await profileService.getProfile()
            self.profile = profile
            handleProfileData(profile)
        } catch {
            handleError(error)
        }
    }
    
    func usernameUpdated(_ username: String) {
        state.username = username

       // TODO: username validation
    }


    func emailUpdated(_ email: String) {
        state.email = email

        do {
            try validateServise.validate(email: email)
            state.emailError = nil
        } catch {
            state.emailError = ValidationErrorHandler.message(for: error)
        }
    }

    func handleProfileData(_ profile: UserProfile) {
        state.username = profile.nickName
        state.email = profile.email
        state.avatarLink = profile.avatarUrl ?? ""
        state.newAvatarLink = state.avatarLink
        state.name = profile.name
    }

    func resetChanges() {
        guard let profile else { return }

        state.name = profile.name
        state.email = profile.email
        state.newAvatarLink = profile.avatarUrl ?? ""
        state.emailError = nil
        state.avatarLinkError = nil
    }

    func updateProfile() async {
        
        guard let id = profile?.id else {
            return
        }
        state.isUpdating = true

        let updatedProfile = UserProfile(
            id: id,
            nickName: state.username,
            name: state.name,
            email: state.email,
            avatarUrl: state.newAvatarLink
        )

        do {
            try await profileService.updateProfile(updatedProfile)
            profile = updatedProfile
            state.avatarLink = updatedProfile.avatarUrl ?? ""
            checkDataIsChange()
        } catch {
            resetChanges()
            handleError(error)
        }
        state.isUpdating = false
    }

    func avatarLinkUpdated(_ urlString: String) {
        state.newAvatarLink = urlString

        guard
            let url = URL(string: urlString),
            url.isImageType()
        else {
            state.avatarLinkError = "ocalizedKey.ErrorMessage.invalidLink"
            return
        }

        state.avatarLinkError = nil
    }

    func checkDataIsChange() {
        guard let profile else { return }

        let isNameChanged = state.name != profile.name
        let isEmailChanged = state.email != profile.email
        let isAvatarLinkChanged = state.newAvatarLink != profile.avatarUrl

        state.isDataChanged = isEmailChanged || isAvatarLinkChanged ||
        isNameChanged
    }
}
