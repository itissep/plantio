import SwiftUI

public struct ProfileView: View {

    @StateObject private var viewModel: ProfileViewModel

    init(viewModel: ProfileViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    public var body: some View {
        VStack {
            Button {
                viewModel.handle(.onEditProfileTapped)
            } label: {
                Text("edit profile")
            }
            
            Text("ProfileView")
        }.onAppear { viewModel.handle(.onAppear) }
        
    }

    private var isAlertPresented: Binding<Bool> {
        Binding(
            get: { viewModel.state.isAlertPresenting },
            set: { viewModel.handle(.onAlertPresented($0)) }
        )
    }
}
