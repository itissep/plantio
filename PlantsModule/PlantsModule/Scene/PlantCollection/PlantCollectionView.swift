import PUI
import SwiftUI
import Models

public struct PlantCollectionView: View {
    
    @StateObject private var viewModel: PlantCollectionViewModel
    
    init(viewModel: PlantCollectionViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        ScrollView(.vertical) {
            if viewModel.state.plants.isEmpty {
                VStack {
                    Spacer()
                        .frame(height: PUI.Spacing.large)
                    Text("no plants here")
                        .foregroundStyle(Color.pui.textSecondary)
                        .font(PUI.Font.title)
                    HStack {
                        Text("you should")
                            .foregroundStyle(Color.pui.textSecondary)
                            .font(PUI.Font.text)
                        Button {
                            viewModel.handle(.onAddPlantTapped)
                        } label: {
                            Text("add")
                        }.inlineButtonStyle(isProminent: true)
                        Text("one")
                            .foregroundStyle(Color.pui.textSecondary)
                            .font(PUI.Font.text)
                    }
                }
            } else {
                ScrollView(.horizontal) {
                    HStack(spacing: PUI.Spacing.medium) {
                        Spacer()
                            .frame(width: PUI.Spacing.large)
                        ForEach(viewModel.state.plants, id: \.id) { plant in
                            ZStack(alignment: .bottomTrailing) {
                                Group {
                                    if let urlString = plant.mainImageUrl, let url = URL(string: urlString) {
                                        PUI.Picture(url)
                                            .frame(width: 95, height: 95)
                                            .clipShape(.rect(cornerRadius: PUI.Constant.cornerRadius))
                                    } else {
                                        RoundedRectangle(cornerRadius: PUI.Constant.cornerRadius)
                                            .foregroundStyle(Color.pui.accent)
                                            .frame(width: 95, height: 95)
                                    }
                                }
                                if viewModel.state.selectedPlant?.id ?? "" == plant.id {
                                    Text("selected")
                                        .font(PUI.Font.caption)
                                        .padding(.all, PUI.Spacing.small)
                                        .background {
                                            RoundedRectangle(cornerRadius: 5)
                                                .foregroundStyle(Color.pui.backgroundPrimary)
                                        }
                                        .padding(.all, PUI.Spacing.small)
                                }
                            }
                            .onTapGesture {
                                viewModel.handle(.onPlantSelectWithId(plant.id))
                            }
                        }
                    }
                }
                .padding(.bottom, PUI.Spacing.large)
                if viewModel.state.selectedPlant == nil {
                    
                    VStack(spacing: PUI.Spacing.large) {
                        Spacer()
                        Text("no plants selected")
                            .foregroundStyle(Color.pui.textSecondary)
                            .font(PUI.Font.title)
                        Text("you should select something")
                            .foregroundStyle(Color.pui.textSecondary)
                            .font(PUI.Font.text)
                        Spacer()
                    }
                } else {
                    VStack(alignment: .leading, spacing: PUI.Spacing.large) {
                        Button {
                            viewModel.handle(.onDeletePlantTapped)
                        } label: {
                            Text("delete this plant")
                        }.buttonStyle(PUI.BaseButtonStyle(isProminent: true))
                        
                        ForEach(viewModel.state.plantEvents, id: \.title) { eventModel in
                            EventTimetableView(viewModel: eventModel)
                                .padding(.bottom, PUI.Spacing.large)
                        }
                        
                        Text("photos")
                            .foregroundStyle(Color.pui.textPrimary)
                            .font(PUI.Font.title)
                        
                        PhotoGridView(
                            urlStrings: viewModel.state.plantPhotos,
                            lastItemIcon: Image(systemName: "plus")
                        ) { id in
                            // TODO: zoom photo
                            
                        } lastItemAction: {
                            viewModel.handle(.onAddPlantTapped)
                        }
                    }.padding(.horizontal, PUI.Spacing.large)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("My plants")
                    .font(PUI.Font.title)
                    .foregroundStyle(Color.pui.accent)
            }
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                PUI.IconButton(Image(systemName: "plus.square.fill"), action: {
                    print("hello")
                })
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { viewModel.handle(.onAppear) }
    }
}
