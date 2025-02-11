import SwiftUI

public extension PUI {
    
    struct BaseProgressView: View {
        
        public init() { }
        
        public var body: some View {
            ProgressView()
                .tint(.pui.accent)
                .frame(maxWidth: .infinity)
        }
    }
    
}
