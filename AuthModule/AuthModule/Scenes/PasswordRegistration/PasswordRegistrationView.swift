import SwiftUI
import PUI

struct PasswordRegistrationView: View {
    
    @StateObject private var viewModel: PasswordRegistrationViewModel

    init(viewModel: PasswordRegistrationViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    private var password: Binding<String> {
        Binding(
            get: { viewModel.state.password },
            set: { viewModel.handle(.passwordChanged($0)) }
        )
    }

    private var confirmPassword: Binding<String> {
        Binding(
            get: { viewModel.state.confirmPassword },
            set: { viewModel.handle(.confirmPasswordChanged($0)) }
        )
    }
    
    var body: some View {
        VStack(spacing: PUI.Spacing.large) {
            Text("password")
            
            Group {
                PUI.SecureInputView(
                    text: password,
                    errorMessage: viewModel.state.passwordError,
                    isErrorShowed: viewModel.state.isPasswordErrorShowing
                )
                .labeled("password")

                PUI.SecureInputView(
                    text: confirmPassword,
                    errorMessage: viewModel.state.confirmPasswordError,
                    isErrorShowed: viewModel.state.isConfirmPasswordErrorShowing
                )
                .labeled("confirmPassword")

                if viewModel.state.isLoading {
                    PUI.BaseProgressView()
                }
            }
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .padding(.bottom)
            .errorFooter(
                message: viewModel.state.registerError,
                isShowed: viewModel.state.isRegisterErrorShowing
            )

            Button("Register") {
                viewModel.handle(.registerTapped)
            }
            .disabled(viewModel.state.isRegisterDisabled)

            Spacer()

            Button("log in") {
                viewModel.handle(.logInTapped)
            }
        }
        .padding(.top)
    }
}
