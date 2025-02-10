import Foundation
import SwiftUI

public extension PUI {
    enum Font {
        public static let text: SwiftUI.Font = .body.monospaced()
        public static let title: SwiftUI.Font = .title.monospaced()
        public static let caption: SwiftUI.Font = .caption.monospaced()
        
        public static let all: [(title: String, font: SwiftUI.Font)] = [
            ("text", text),
            ("title", title),
            ("caption", caption),
        ]
    }
}
