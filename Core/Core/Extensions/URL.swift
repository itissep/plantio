import UIKit

public extension URL {
    enum Constants {
        static let imageFormats = ["jpg", "png", "gif", "svg", "webp"]
    }

    @MainActor func isImageType() -> Bool {
        UIApplication.shared.canOpenURL(self) &&
        Constants.imageFormats.contains(self.pathExtension.lowercased())
    }
}
