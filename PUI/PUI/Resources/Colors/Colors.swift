import SwiftUI

public extension SwiftUI.Color {
    class PUIColor {
        public let accent: SwiftUI.Color = SwiftUI.Color(.accent)
        public let accentButton: SwiftUI.Color = SwiftUI.Color(.accentButton)
        public let backgroundInverse: SwiftUI.Color = SwiftUI.Color(.backgroundInverse)
        public let backgroundPrimary: SwiftUI.Color = SwiftUI.Color(.backgroundPrimary)
        public let backgroundSecondary: SwiftUI.Color = SwiftUI.Color(.backgroundSecondary)
        public let textPrimary: SwiftUI.Color = SwiftUI.Color(.textPrimary)
        public let textSecondary: SwiftUI.Color = SwiftUI.Color(.textSecondary)
                
//        public let all: [(title: String, color: SwiftUI.Color)] = [
//            ("accent", accent),
//            ("accentButton", accentButton),
//            ("backgroundInverse", backgroundInverse),
//            ("backgroundPrimary", backgroundPrimary),
//            ("backgroundSecondary", backgroundSecondary),
//            ("textPrimary", textPrimary),
//            ("textSecondary", textSecondary),
//        ]
    }
    
    static var pui = PUIColor()
}
