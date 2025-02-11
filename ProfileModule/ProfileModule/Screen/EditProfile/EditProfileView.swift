import SwiftUI
import PUI

public struct EditProfileView: View {

    @StateObject private var viewModel: EditProfileViewModel

    init(viewModel: EditProfileViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    public var body: some View {
        ScrollView {
            VStack(spacing: Constants.contentSpacing) {
                VStack {
                    // TODO: add avatar image here

                    Text(viewModel.state.username)
                        .font(.title2)
                        .bold()
                }

                VStack(spacing: Constants.formSpacing) {
                    VStack {
                        TextField("", text: email)
                            .formItem()
                            .errorFooter(
                                message: viewModel.state.emailError,
                                isShowed: viewModel.state.isEmailErrorShowing
                            )
                            .labeled("LocalizedKey.Profile.email")

                        TextField("", text: avatarLink)
                            .formItem()
                            .errorFooter(
                                message: viewModel.state.avatarLinkError,
                                isShowed: viewModel.state.isAvatarLinkErrorShowing
                            )
                            .labeled("LocalizedKey.Profile.avatarLink")
                    }
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)

                    TextField("", text: name)
                        .formItem()
                        .labeled("LocalizedKey.Profile.name")
                }
                .padding(.horizontal)

                if viewModel.state.isUpdating {
                    ProgressView()
                        .tint(Color.pui.accent)
                } else {
                    VStack(spacing: Constants.buttonSpacing) {
                        Button("LocalizedKey.Profile.save") {
                            viewModel.handle(.saveTapped)
                        }
                        .baseButtonStyle()
                        .disabled(viewModel.state.isSaveDisabled)

                        Button("LocalizedKey.Profile.cancel") {
                            viewModel.handle(.cancelTapped)
                        }
                        .baseButtonStyle(isProminent: false)
                        .disabled(!viewModel.state.isDataChanged)
                    }
                    .padding()
                }
            }
            .padding(.top)
        }
        .scrollIndicators(.hidden)
        .alert("LocalizedKey.ErrorMessage.error", isPresented: isAlertPresented) {
            Button("OK", role: .cancel, action: {})
        } message: {
            Text(LocalizedStringKey(viewModel.state.errorMessage))
        }
        .onAppear {
            viewModel.handle(.onAppear)
        }
    }

    private enum Constants {
        static let logOutTopInset: CGFloat = 1

        static let formSpacing: CGFloat = 15
        static let buttonSpacing: CGFloat = 17
        static let contentSpacing: CGFloat = 18
        static let profileImageSize: CGFloat = 80
    }

    private var email: Binding<String> {
        Binding(
            get: { viewModel.state.email },
            set: { viewModel.handle(.emailChanged($0)) }
        )
    }

    private var avatarLink: Binding<String> {
        Binding(
            get: { viewModel.state.newAvatarLink },
            set: { viewModel.handle(.avatarLinkChanged($0)) }
        )
    }

    private var name: Binding<String> {
        Binding(
            get: { viewModel.state.name },
            set: { viewModel.handle(.nameChanged($0)) }
        )
    }

    private var isAlertPresented: Binding<Bool> {
        Binding(
            get: { viewModel.state.isAlertPresenting },
            set: { viewModel.handle(.onAlertPresented($0)) }
        )
    }
}

