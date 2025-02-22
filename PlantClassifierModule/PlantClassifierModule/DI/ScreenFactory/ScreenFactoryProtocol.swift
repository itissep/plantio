import SwiftUI

@MainActor
public protocol ClassifierViewFactory {
    func makeClassifierView(coordinator: ClassifierCoordinatorProtocol) -> ClassifierView
}
