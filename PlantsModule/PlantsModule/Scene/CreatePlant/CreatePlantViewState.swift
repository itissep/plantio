import Foundation

struct CreatePlantViewState: Equatable {
    var name = ""
    var description = ""
    var imageData: Data? = nil

    var errorMessage: String = ""

    var isUpdating = false
    var isAlertPresenting = false

    var isSaveDisabled: Bool {
        imageData == nil || name.isEmpty || description.isEmpty
    }
}

enum CreatePlantViewEvent {
    case onAppear
    
    case saveTapped
    case cancelTapped

    case imageChanged(Data?)
    case nameChanged(String)
    case descriptionChanged(String)
    case onAlertPresented(Bool)
}
