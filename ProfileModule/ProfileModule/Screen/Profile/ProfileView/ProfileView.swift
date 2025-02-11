import SwiftUI
import PUI

public struct ProfileView: View {

    @StateObject private var viewModel: ProfileViewModel

    init(viewModel: ProfileViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    public var body: some View {
        ScrollView {
            VStack(spacing: PUI.Spacing.large) {
                HStack(spacing: PUI.Spacing.medium) {
                    PUI.IconButton(Image(systemName: "person.2.badge.plus.fill")) {
                        viewModel.handle(.onAddFriendsTapped)
                    }
                    Spacer()
                    PUI.IconButton(Image(systemName: "pencil")) {
                        viewModel.handle(.onEditProfileTapped)
                    }
                    
                    PUI.IconButton(Image(systemName: "square.and.arrow.up.fill")) {
                        viewModel.handle(.onShareButtonTapped)
                    }
                }
                
                VStack(spacing: PUI.Spacing.medium) {
                    PUI.Picture(URL(string: viewModel.state.avatarLink))
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                    
                    Text(viewModel.state.name)
                        .font(PUI.Font.title)
                        .bold()
                        .foregroundStyle(Color.pui.textPrimary)
                    
                    Text(viewModel.state.description)
                        .font(PUI.Font.text)
                        .foregroundStyle(Color.pui.textSecondary)
                }
                
                Spacer()
                    .frame(height: PUI.Spacing.large)
                
                PlantsGrid(
                    plants: viewModel.state.plants,
                    lastItemIcon: Image(systemName: "plus"),
                    onPlantTap: { viewModel.handle(.onPlantSelectWithId($0)) },
                    lastItemAction: { viewModel.handle(.onAddPlantTapped) }
                )
            }
        }
        .scrollIndicators(.hidden)
        .padding(.horizontal, PUI.Spacing.large)
        .onAppear { viewModel.handle(.onAppear) }
    }
}
