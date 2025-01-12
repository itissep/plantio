import Foundation
import SwiftUI

public extension PUI {
    struct TabLabel: View {
        let label: String
        let icon: Image
        
        public init(label: String, icon: Image) {
            self.label = label
            self.icon = icon
        }
        
        public var body: some View {
            Label(
                title: { Text(label) },
                icon: { icon }
            )
        }
    }
}
