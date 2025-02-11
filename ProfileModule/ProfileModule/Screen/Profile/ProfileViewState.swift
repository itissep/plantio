import Foundation
import Models

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
    var description = ""
    var avatarLink: String  = ""
    
    // TODO: add plants
    var plants: [Plant] = [
        .init(name: "some plant"), .init(name: "some plant"), .init(name: "some plant"), .init(name: "some plant"),
    ]
    // TODO: add frinds
    
    // Service
    var isLoading = false
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
