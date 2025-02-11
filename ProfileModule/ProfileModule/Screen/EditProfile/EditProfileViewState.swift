import Foundation

struct EditProfileViewState: Equatable {
    var username = ""
    var email = ""
    var name = ""
    var avatarLink: String  = ""
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
    case onAlertPresented(Bool)
}
