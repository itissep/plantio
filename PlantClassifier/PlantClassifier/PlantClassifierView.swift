//
//  PlantClassifierView.swift
//  PlantClassifier
//
//  Created by Уля on 04.01.2025.
//

import SwiftUI
import PhotosUI

public struct PlantClassifierView: View {
    @StateObject var viewModel = PlantClassifierService()

        @State var showSelection = false
        @State private var selectedItem: PhotosPickerItem?
    
    public init() { }

        public var body: some View {
            VStack {
                if viewModel.selectedImage != nil {
                    Image(uiImage: viewModel.selectedImage!)
                        .resizable()
                        .scaledToFit()
                        .frame(minWidth: 0.0, maxWidth: .infinity)
                }
                Button {
                    viewModel.tryImage()
                } label: {
                    Text("Try")
                }

                PhotosPicker(
                    selection: $selectedItem,
                    matching: .images,
                    photoLibrary: .shared()) {
                        Text("Загрузить видео из галлереи")
                    }
                    .onChange(of: selectedItem) { newItem, _ in
                        Task {
                            if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                viewModel.selectedImage = UIImage(data: data)
                            }
                        }
                    }
            }
        }
}
