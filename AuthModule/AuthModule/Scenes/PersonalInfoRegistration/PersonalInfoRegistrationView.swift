import SwiftUI
import PUI

struct PersonalInfoRegistrationView: View {
    
    @StateObject private var viewModel: PersonalInfoRegistrationViewModel

    init(viewModel: PersonalInfoRegistrationViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    private var name: Binding<String> {
        Binding(
            get: { viewModel.state.name },
            set: { viewModel.handle(.nameChanged($0)) }
        )
    }

    private var username: Binding<String> {
        Binding(
            get: { viewModel.state.username },
            set: { viewModel.handle(.usernameChanged($0)) }
        )
    }

    private var email: Binding<String> {
        Binding(
            get: { viewModel.state.email },
            set: { viewModel.handle(.emailChanged($0)) }
        )
    }
    
    var body: some View {
        VStack(spacing: PUI.Spacing.large) {
            Text("Personal reg info")
            
            TextField("", text: name)
                .labeled("name")
            
            TextField("", text: username)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .formErrorableItem(
                    message: viewModel.state.usernameError,
                    isErrorShowed: viewModel.state.isUsernameErrorShowing
                )
                .labeled("username")
            
            TextField("", text: email)
                .keyboardType(.emailAddress)
                .formErrorableItem(
                    message: viewModel.state.emailError,
                    isErrorShowed: viewModel.state.isEmailErrorShowing
                )
                .labeled("email")
            
            Button("logInToAccount") {
                viewModel.handle(.continueTapped)
            }
            .disabled(viewModel.state.isContinueDisabled)
            
            Spacer()
            
            Button("alreadyHaveAccount") {
                viewModel.handle(.logInTapped)
            }
        }
        .padding(.top)
    }
}
