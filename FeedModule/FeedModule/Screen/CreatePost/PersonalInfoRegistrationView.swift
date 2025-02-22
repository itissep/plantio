import SwiftUI
import PUI

public struct CreatePostView: View {
    
    @StateObject private var viewModel: CreatePostViewModel
    
    init(viewModel: CreatePostViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    private var title: Binding<String> {
        Binding(
            get: { viewModel.state.title },
            set: { viewModel.handle(.titleChanged($0)) }
        )
    }
    
    private var text: Binding<String> {
        Binding(
            get: { viewModel.state.text },
            set: { viewModel.handle(.textChanged($0)) }
        )
    }
    
    public var body: some View {
        VStack(spacing: PUI.Spacing.large) {
            Text("Post creation")
                .font(PUI.Font.title)
                .foregroundStyle(Color.pui.textPrimary)
            
            TextField("", text: title)
                .formItem()
                .labeled("title")
            
            TextField("", text: text)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
            //                .formItem(
            //                    errorMessage: viewModel.state.usernameError,
            //                    isErrorShowed: viewModel.state.isUsernameErrorShowing
            //                )
                .labeled("text")
            
            // TODO: add photo and plant attach
            
            Button("next step") { viewModel.handle(.createPostTapped) }
                .disabled(viewModel.state.isCreationEnabled)
                .baseButtonStyle()
            
        }.padding(.bottom, PUI.Spacing.large)
    }
}

