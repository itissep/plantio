import SwiftUI
import PUI

public struct EditProfileView: View {

    @StateObject private var viewModel: EditProfileViewModel

    init(viewModel: EditProfileViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    public var body: some View {
        ScrollView {
            VStack(spacing: PUI.Spacing.large) {
                
                Text("edit profile")
                    .font(PUI.Font.title)
                    .foregroundStyle(Color.pui.textPrimary)
            
                ZStack(alignment: .bottomTrailing) {
                    AsyncImage(url: URL(string: viewModel.state.avatarLink)) { phase in
                        switch phase {
                        case .empty:
                            ZStack {
                                Color.pui.backgroundSecondary
                                ProgressView()
                                    .tint(Color.pui.accent)
                            }
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                        case .failure(_):
                            ZStack {
                                Color.pui.backgroundSecondary
                                Image(systemName: "photo.fill")
                                    .font(.title)
                                    .tint(Color.pui.accent)
                            }
                        default:
                            Color.pui.backgroundSecondary
                        }
                    }
                    .frame(width: 250, height: 250)
                    .clipShape(Circle())
                
                    Button {
                        viewModel.handle(.avatarLinkChanged("https://thumbs.dreamstime.com/b/cute-kitten-flowers-smelling-120490331.jpg"))
                    } label: {
                        Circle()
                            .foregroundStyle(Color.pui.backgroundSecondary)
                            .overlay {
                                Image(systemName: "pencil")
                                    .font(.title)
                                    .foregroundStyle(Color.pui.accent)
                            }
                    }
                    .buttonStyle(.plain)
                    .frame(width: 50, height: 50)
                    .padding(.trailing, PUI.Spacing.large)
                    .padding(.bottom, PUI.Spacing.large)
                }
                
                TextField("type your name here", text: name)
                    .formItem()
                    .labeled("name")
                
                TextField("", text: username)
                    .formItem()
                    .labeled("username")
                
                TextField("", text: description)
                    .formItem()
                    .labeled("description")

                if viewModel.state.isUpdating {
                    ProgressView()
                        .tint(Color.pui.accent)
                } else {
                    VStack(spacing: Constants.buttonSpacing) {
                        Button("save") {
                            viewModel.handle(.saveTapped)
                        }
                        .baseButtonStyle()
                        .disabled(viewModel.state.isSaveDisabled)

                        Button("reset changes") {
                            viewModel.handle(.cancelTapped)
                        }
                        .inlineButtonStyle()
                        .disabled(!viewModel.state.isDataChanged)
                    }
                }
            }
            .padding(.all, PUI.Spacing.large)
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
    
    private var username: Binding<String> {
        Binding(
            get: { viewModel.state.username },
            set: { viewModel.handle(.usernameChanged($0)) }
        )
    }
    
    private var description: Binding<String> {
        Binding(
            get: { viewModel.state.description },
            set: { viewModel.handle(.descriptionChanged($0)) }
        )
    }

    private var isAlertPresented: Binding<Bool> {
        Binding(
            get: { viewModel.state.isAlertPresenting },
            set: { viewModel.handle(.onAlertPresented($0)) }
        )
    }
}

