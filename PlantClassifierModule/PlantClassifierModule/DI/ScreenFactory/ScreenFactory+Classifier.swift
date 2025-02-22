import Foundation
import Core

extension ScreenFactory: ClassifierViewFactory {
    public func makeClassifierView(coordinator: ClassifierCoordinatorProtocol) -> ClassifierView {
        let viewModel: ClassifierViewModel = serviceLocator.resolve()!
        return ClassifierView(viewModel: viewModel)
    }
}
