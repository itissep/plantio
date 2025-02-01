import SwiftUI
import PUI

struct WelcomeView: View {
    @StateObject private var viewModel: WelcomeViewModel

    init(viewModel: WelcomeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(spacing: PUI.Spacing.medium) {
            Image(systemName: "tree.fill")
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 50)
                .foregroundColor(PUI.Color.accent)
            
            VStack(spacing: PUI.Spacing.small) {
                Text("Welcome")
                    .font(PUI.Font.title)
                
                Text("Some kind words")
                    .font(PUI.Font.text)
            }
            .multilineTextAlignment(.center)
            
            Spacer()
                .frame(height: PUI.Spacing.large)
            
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
