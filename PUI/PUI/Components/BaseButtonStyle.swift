import SwiftUI

public extension PUI {
    struct BaseButtonStyle: ButtonStyle {

        let isProminent: Bool
        @Environment(\.isEnabled) var isEnabled: Bool

        public func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .font(PUI.Font.text)
                .foregroundStyle(isEnabled ? PUI.Color.backgroundPrimary : PUI.Color.textPrimary)
                .frame(maxWidth: .infinity)
                .frame(height: 42)
                .background(isProminent ? PUI.Color.accent : PUI.Color.accentButton)
                .clipShape(.rect(cornerRadius: PUI.Constant.cornerRadius))
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
    func baseButtonStyle(isProminent: Bool = true) -> some View {
        buttonStyle(PUI.BaseButtonStyle(isProminent: isProminent))
    }
}
