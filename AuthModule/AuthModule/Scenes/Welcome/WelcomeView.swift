import SwiftUI
import PUI

struct WelcomeView: View {
    @StateObject private var viewModel: WelcomeViewModel

    init(viewModel: WelcomeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(spacing: PUI.Spacing.medium) {
            Image(systemName: "phone")
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 50)
            
            VStack(spacing: PUI.Spacing.small) {
                Text("Welcome")
                    .bold()
                    .font(.title2)
                
                Text("Some kind words")
                    .font(.body)
            }
            .multilineTextAlignment(.center)
            .padding()
            
            VStack(spacing: PUI.Spacing.small) {
                Button("Registration") {
                    viewModel.handle(.registrationTapped)
                }
                
                Button("Login") {
                    viewModel.handle(.logInTapped)
                }
            }
            .padding(.horizontal)
        }
    }
}
