import SwiftUI

public extension PUI {
    struct SecureInputView: View {

        @Binding public var text: String

        public var errorMessage: String?
        public var isErrorShowed: Bool = false

        @State private var isSecured = true
        
        public init(text: Binding<String>, errorMessage: String? = nil, isErrorShowed: Bool = false) {
                self._text = text
                self.errorMessage = errorMessage
                self.isErrorShowed = isErrorShowed
        }

        public var body: some View {
            HStack(spacing: Constants.contentSpacing) {
                textField
                    .labelsHidden()

                Image(systemName: isSecured ? Constants.Image.eyeSlash : Constants.Image.eye)
                    .imageScale(.medium)
                    .foregroundStyle(.secondary)
                    .padding(.trailing)
                    .onTapGesture {
                        isSecured.toggle()
                    }
            }
            .formItem(
                errorMessage: errorMessage,
                isErrorShowed: isErrorShowed
            )
        }

        private enum Constants {
            static let contentSpacing: CGFloat = 0

            enum Image {
                static let eye = "eye"
                static let eyeSlash = "eye.slash"
                static let trailingInset: CGFloat = 12
            }
        }

        @ViewBuilder
        private var textField: some View {
            if isSecured {
                SecureField("", text: $text)
            } else {
                SwiftUI.TextField("", text: $text)
            }
        }
    }
}
