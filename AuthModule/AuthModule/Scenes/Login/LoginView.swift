import SwiftUI
import PUI

struct LoginView: View {
    @StateObject private var viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    private var username: Binding<String> {
        Binding(
            get: { viewModel.state.username },
            set: { viewModel.handle(.usernameChanged($0)) }
        )
    }
    
    private var password: Binding<String> {
        Binding(
            get: { viewModel.state.password },
            set: { viewModel.handle(.passwordChanged($0)) }
        )
    }
    
    var body: some View {
        VStack(spacing: PUI.Spacing.large) {
            
            Text("Login title")
                .font(PUI.Font.title)
                .foregroundStyle(Color.pui.textPrimary)
            
            Group {
                
                TextField("", text: username)
                    .formItem()
                    .labeled("username")
                
                PUI.SecureInputView(text: password, isErrorShowed: viewModel.state.isLoginErrorShowing)
                    .labeled("password")
                
                if viewModel.state.isLoading {
                    PUI.BaseProgressView()
                }
            }
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .padding(.bottom, PUI.Spacing.large)
            .errorFooter(
                message: viewModel.state.loginError,
                isShowed: viewModel.state.isLoginErrorShowing
            )
            
            Button("Log in") { viewModel.handle(.logInTapped) }
                .disabled(viewModel.state.isLogInDisabled)
                .baseButtonStyle()
            Spacer()
            
            VStack(spacing: PUI.Spacing.medium) {
                Text("no account yet?")
                    .font(PUI.Font.caption)
                    .foregroundStyle(Color.pui.textSecondary)
                Button("sign up") { viewModel.handle(.registerTapped) }
                    .inlineButtonStyle()
            }.padding(.bottom, PUI.Spacing.large)
            
        }
        .padding(.horizontal, PUI.Spacing.large)
    }
}
