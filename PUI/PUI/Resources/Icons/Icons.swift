import SwiftUI

public extension Image {
    class PUIImage {
        public let iconCircle: Image = Image(.iconCircle)
        public let iconRounded: Image = Image(.iconRounded)
        public let placeholder: Image = Image(.placeholder)
    }
    
    static let pui = PUIImage()
}
