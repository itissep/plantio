import SwiftUI
import PUI

public struct CreatePlantView: View {

    @StateObject private var viewModel: CreatePlantViewModel

    init(viewModel: CreatePlantViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    public var body: some View {
        ScrollView {
            VStack(spacing: PUI.Spacing.large) {
                
                Text("new plant")
                    .font(PUI.Font.title)
                    .foregroundStyle(Color.pui.textPrimary)
            
                ZStack(alignment: .bottomTrailing) {
//                    AsyncImage(url: URL(string: viewModel.state.imageData)) { phase in
//                        switch phase {
//                        case .empty:
//                            ZStack {
//                                Color.pui.backgroundSecondary
//                                ProgressView()
//                                    .tint(Color.pui.accent)
//                            }
//                        case .success(let image):
//                            image
//                                .resizable()
//                                .scaledToFill()
//                        case .failure(_):
//                            ZStack {
//                                Color.pui.backgroundSecondary
//                                Image(systemName: "photo.fill")
//                                    .font(.title)
//                                    .tint(Color.pui.accent)
//                            }
//                        default:
//                            Color.pui.backgroundSecondary
//                        }
//                    }
//                    .frame(width: 250, height: 250)
//                    .clipShape(Circle())
                
                    Button {
//                        viewModel.handle(.avatarLinkChanged("https://thumbs.dreamstime.com/b/cute-kitten-flowers-smelling-120490331.jpg"))
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
                
                TextField("type plant's name here", text: name)
                    .formItem()
                    .labeled("name")
                
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
                    }
                }
            }
            .padding(.all, PUI.Spacing.large)
        }
        .scrollIndicators(.hidden)
        .alert("some error appeared", isPresented: isAlertPresented) {
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

    private var imageData: Binding<Data?> {
        Binding(
            get: { viewModel.state.imageData },
            set: { viewModel.handle(.imageChanged($0)) }
        )
    }

    private var name: Binding<String> {
        Binding(
            get: { viewModel.state.name },
            set: { viewModel.handle(.nameChanged($0)) }
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
