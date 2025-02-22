import SwiftUI
import PhotosUI
import PUI

public struct ClassifierView: View {
    @StateObject var viewModel: ClassifierViewModel
    
    @State var showSelection = false
    @State private var selectedItem: PhotosPickerItem?
    
    @State private var prediction: String?
    @State private var isLoaderAnimating: Bool = false
    
    public init(viewModel: ClassifierViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        VStack {
            Text("Plant Classifier")
                .font(PUI.Font.title)
                .foregroundStyle(Color.pui.accent)
                .padding(.bottom, PUI.Spacing.large)
            Group {
                if viewModel.selectedImage != nil {
                    Image(uiImage: viewModel.selectedImage!)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 300, height: 300)
                        .clipShape(.rect(cornerRadius: PUI.Constant.cornerRadius))
                        .overlay {
                            if viewModel.isLoading { loader }
                        }
                } else {
                    RoundedRectangle(cornerRadius: PUI.Constant.cornerRadius)
                        .foregroundStyle(Color.pui.accent)
                        .frame(width: 300, height: 300)
                        .overlay {
                            if viewModel.isLoading {
                                loader
                            } else {
                                Text("image")
                                    .monospaced()
                                    .foregroundStyle(.background)
                            }
                        }
                }
            }
            .padding(.bottom, PUI.Spacing.large)
            
            PhotosPicker(
                selection: $selectedItem,
                matching: .images,
                photoLibrary: .shared()
            ) { Text("pick new image") }
                .baseButtonStyle()
                .frame(width: 300)
                .onChange(of: selectedItem) { _, newItem in
                    viewModel.isLoading = true
                    Task {
                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                            viewModel.selectedImage = UIImage(data: data)
                            viewModel.isLoading = false
                        }
                    }
                }
            Button("which plant it is?") { viewModel.tryImage() }
                .baseButtonStyle()
                .disabled(viewModel.selectedImage == nil)
                .padding(.bottom, PUI.Spacing.large)
                .frame(width: 300)
            
            Group {
                if !viewModel.predictionsTop3.isEmpty {
                    ForEach(viewModel.predictionsTop3, id: \.name) { item in
                        HStack() {
                            Image(systemName: "\(item.place + 1).square.fill")
                                .font(.system(size: 42))
                            Text(item.name)
                            Spacer()
                            Text("\(item.confidence)")
                                .bold()
                        }
                    }
                } else {
                    HStack {
                        Image.pui.iconRounded
                            .resizable()
                            .frame(width: 42, height: 42)
                        Spacer()
                        Text("your plant prediction is going to be here")
                            .monospaced()
                            .foregroundStyle(Color.pui.accent)
                            .multilineTextAlignment(.leading)
                    }
                }
            }
            .frame(width: 300)
            .foregroundStyle(Color.pui.accent)
            .monospaced()
        }
    }
    
    private var loader: some View {
        RoundedRectangle(cornerRadius: PUI.Constant.cornerRadius)
            .foregroundStyle(Color.pui.accent)
            .frame(width: 300, height: 300)
            .overlay {
                Image.pui.iconRounded
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(Color.pui.backgroundPrimary)
                    .rotationEffect(.degrees(isLoaderAnimating ? 360 : 0))
                    .animation(Animation.linear(duration: 2).repeatForever(autoreverses: false), value: isLoaderAnimating)
                    .onAppear { isLoaderAnimating = true }
                    .onDisappear { isLoaderAnimating = false }
            }
    }
}
