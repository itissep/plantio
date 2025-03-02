import SwiftUI
import PUI
import PhotosUI

struct AddPhotoSheet: View {
    @Environment(\.dismiss) var dismiss
    
    @State var imageData: Data? = nil
    @State private var selectedItem: PhotosPickerItem?
    
    var onAddTapped: (Data?) -> Void
    
    var body: some View {
        VStack {
            
            if
                let imageData = imageData,
                let image = UIImage(data: imageData)
            {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300, height: 300)
                    .clipShape(.rect(cornerRadius: PUI.Constant.cornerRadius))
            } else {
                RoundedRectangle(cornerRadius: PUI.Constant.cornerRadius)
                    .foregroundStyle(Color.pui.accent)
                    .frame(width: 300, height: 300)
                    .overlay {
                        Text("image")
                            .monospaced()
                            .foregroundStyle(.background)
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
                        self.imageData = try? await newItem?.loadTransferable(type: Data.self)
                    }
                }
            
            Button("add") {
                onAddTapped(imageData)
                dismiss()
            }
            .baseButtonStyle()
            .frame(width: 300)
            
            Button("cancel") {
                dismiss()
            }
            .inlineButtonStyle(isProminent: true)
            .frame(width: 300)
        }
        .padding()
    }
}
