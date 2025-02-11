import Foundation

struct EditProfileViewState: Equatable {
    var username = ""
    var email = ""
    var name = ""
    var description = ""
    var avatarLink: String  = "https://i.pinimg.com/originals/fe/f8/7e/fef87efc5f2f87435fa3015dacff97c8.jpg"
    var newAvatarLink: String  = ""

    var emailError: String?
    var avatarLinkError: String?
    var errorMessage: String = ""

    var isUpdating = false
    var isDataChanged = false
    var isAlertPresenting = false

    var isEmailErrorShowing: Bool {
        email.isEmpty == false && emailError != nil
    }

    var isAvatarLinkErrorShowing: Bool {
        newAvatarLink.isEmpty == false && avatarLinkError != nil
    }

    var isSaveDisabled: Bool {
        email.isEmpty || emailError != nil || newAvatarLink.isEmpty ||
        avatarLinkError != nil || name.isEmpty || isDataChanged == false
    }
}

enum EditProfileViewEvent {
    case onAppear
    
    case saveTapped
    case cancelTapped

    case emailChanged(String)
    case avatarLinkChanged(String)
    case nameChanged(String)
    case usernameChanged(String)
    case descriptionChanged(String)
    case onAlertPresented(Bool)
}
