import Foundation
import SwiftUI

public extension PUI {
    enum Color: CaseIterable {
        public static let accent: SwiftUI.Color = SwiftUI.Color(hex: "#B1C07A") ?? SwiftUI.Color.orange
        public static let accentButton: SwiftUI.Color = SwiftUI.Color(hex: "#F2AB74") ?? SwiftUI.Color.orange
        public static let backgroundInverse: SwiftUI.Color = SwiftUI.Color(hex: "#909E66") ?? SwiftUI.Color.orange
        public static let backgroundPrimary: SwiftUI.Color = SwiftUI.Color(hex: "#FFFFFF") ?? SwiftUI.Color.orange
        public static let backgroundSecondary: SwiftUI.Color = SwiftUI.Color(hex: "#F8FAF6") ?? SwiftUI.Color.orange
        public static let textPrimary: SwiftUI.Color = SwiftUI.Color(hex: "#453C35") ?? SwiftUI.Color.orange
        public static let textSecondary: SwiftUI.Color = SwiftUI.Color(hex: "#D7D7D7") ?? SwiftUI.Color.orange
        
        public static let all: [(title: String, color: SwiftUI.Color)] = [
            ("accent", accent),
            ("accentButton", accentButton),
            ("backgroundInverse", backgroundInverse),
            ("backgroundPrimary", backgroundPrimary),
            ("backgroundSecondary", backgroundSecondary),
            ("textPrimary", textPrimary),
            ("textSecondary", textSecondary),
        ]
    }
}
