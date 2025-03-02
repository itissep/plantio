import SwiftUI
import PUI
import PhotosUI

public struct CreatePlantView: View {

    @StateObject private var viewModel: CreatePlantViewModel
    @State var showSelection = false
    @State private var selectedItem: PhotosPickerItem?

    init(viewModel: CreatePlantViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    public var body: some View {
        ScrollView {
            VStack(spacing: PUI.Spacing.large) {
                
                Text("new plant")
                    .font(PUI.Font.title)
                    .foregroundStyle(Color.pui.textPrimary)
            
                if
                    let imageData = viewModel.state.imageData,
                    let image = UIImage(data: imageData)
                {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 300, height: 300)
                        .clipShape(.rect(cornerRadius: PUI.Constant.cornerRadius))
//                        .overlay {
//                            if viewModel.isLoading { loader }
//                        }
                } else {
                    RoundedRectangle(cornerRadius: PUI.Constant.cornerRadius)
                        .foregroundStyle(Color.pui.accent)
                        .frame(width: 300, height: 300)
                        .overlay {
//                            if viewModel.isLoading {
//                                loader
//                            } else {
                                Text("image")
                                    .monospaced()
                                    .foregroundStyle(.background)
//                            }
                        }
                }
                    
                PhotosPicker(
                    selection: $selectedItem,
                    matching: .images,
                    photoLibrary: .shared()
                ) { Text("pick new image") }
                    .baseButtonStyle()
                    .frame(width: 300)
                    .onChange(of: selectedItem) { _, newItem in
                        Task {
                            self.viewModel.handle(.imageChanged(try? await newItem?.loadTransferable(type: Data.self)))
                        }
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
    
//    private var loader: some View {
//        RoundedRectangle(cornerRadius: PUI.Constant.cornerRadius)
//            .foregroundStyle(Color.pui.accent)
//            .frame(width: 300, height: 300)
//            .overlay {
//                Image.pui.iconRounded
//                    .resizable()
//                    .frame(width: 40, height: 40)
//                    .foregroundStyle(Color.pui.backgroundPrimary)
//                    .rotationEffect(.degrees(isLoaderAnimating ? 360 : 0))
//                    .animation(Animation.linear(duration: 2).repeatForever(autoreverses: false), value: isLoaderAnimating)
//                    .onAppear { isLoaderAnimating = true }
//                    .onDisappear { isLoaderAnimating = false }
//            }
//    }
}
