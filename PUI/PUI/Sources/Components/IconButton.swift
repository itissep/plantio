import SwiftUI

public extension PUI {
    struct IconButton: View {
        var icon: Image
        var action: () -> Void
        
        public init(_ icon: Image, action: @escaping () -> Void) {
            self.icon = icon
            self.action = action
        }
        
        public var body: some View {
            Button {
                action()
            } label: {
                icon
                    .foregroundStyle(Color.pui.accent)
                    .font(.system(size: 20))
                    .bold()
                    .background {
                        Circle()
                            .foregroundStyle(Color.pui.backgroundSecondary)
                            .frame(width: 40, height: 40)
                        
                    }
            }.frame(width: 50, height: 50)
        }
    }
}
