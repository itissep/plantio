import Foundation

enum SortyType {
    case byDate
    case byNickname
    case bySpecies
}

enum SortDirection {
    case asc
    case desc
}

struct ProfileViewState: Equatable {
    // User Data
    var name = ""
    var avatarLink: String  = ""
    
    // TODO: add plants
    // TODO: add frinds
    
    // Service
    var isUpdating = false
    var isAlertPresenting = false
    var errorMessage: String = ""
}

enum ProfileViewEvent {
    case onAppear
    case onAlertPresented(Bool)
    
    case onEditProfileTapped
    case onAddPlantTapped
    case onAddFriendsTapped
    
    case onShareButtonTapped
    case onSortTypeChanged
    
    case onPlantSelectWithId(String)
    case onFriendSelectWithId(String)
}
