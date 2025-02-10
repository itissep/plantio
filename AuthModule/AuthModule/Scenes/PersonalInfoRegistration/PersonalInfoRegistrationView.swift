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
                .font(PUI.Font.title)
                .foregroundStyle(PUI.Color.textPrimary)
            
            TextField("", text: name)
                .formItem()
                .labeled("name")
            
            TextField("", text: username)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .formItem(
                    errorMessage: viewModel.state.usernameError,
                    isErrorShowed: viewModel.state.isUsernameErrorShowing
                )
                .labeled("username")
            
            TextField("", text: email)
                .keyboardType(.emailAddress)
                .formItem(
                    errorMessage: viewModel.state.emailError,
                    isErrorShowed: viewModel.state.isEmailErrorShowing
                )
                .labeled("email")
            
            Button("next step") { viewModel.handle(.continueTapped) }
                .disabled(viewModel.state.isContinueDisabled)
                .baseButtonStyle()
                
            Spacer()
            
            VStack(spacing: PUI.Spacing.medium) {
                Text("already have an account?")
                    .font(PUI.Font.caption)
                    .foregroundStyle(PUI.Color.textSecondary)
                Button("log in") { viewModel.handle(.logInTapped) }
                    .inlineButtonStyle()
                
            }.padding(.bottom, PUI.Spacing.large)
        }
        .padding(.horizontal, PUI.Spacing.large)
    }
}
