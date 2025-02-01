import SwiftUI

public extension PUI {
    struct InlineButtonStyle: ButtonStyle {

        let isProminent: Bool
        @Environment(\.isEnabled) var isEnabled: Bool

        public func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .font(PUI.Font.text)
                .foregroundStyle(isProminent ? PUI.Color.accent : PUI.Color.accentButton)
                .opacity(configuration.isPressed ? Constants.opacityPressed : opacity)
        }

        private enum Constants {
            static let height: CGFloat = 42
            static let borderRadius: CGFloat = 10

            static let scaleEffect: CGFloat = 1
            static let scaleEffectPressed: CGFloat = 0.98

            static let opacityEnabled: CGFloat = 1
            static let opacityPressed: CGFloat = 0.7
            static let opacityDisabled: CGFloat = 0.4
        }

        private var opacity: CGFloat {
            isEnabled ? Constants.opacityEnabled : Constants.opacityDisabled
        }
    }
}

public extension View {
    func inlineButtonStyle(isProminent: Bool = true) -> some View {
        buttonStyle(PUI.InlineButtonStyle(isProminent: isProminent))
    }
}
