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
                    .foregroundStyle(PUI.Color.textPrimary)
                
                Text("Some kind words")
                    .font(PUI.Font.text)
                    .foregroundStyle(PUI.Color.textSecondary)
            }
            .multilineTextAlignment(.center)
            
            Spacer()
                .frame(height: 50)
            
            VStack(spacing: PUI.Spacing.large) {
                Button("Registration") { viewModel.handle(.registrationTapped)}
                    .baseButtonStyle()
                
                Button("Login") { viewModel.handle(.logInTapped) }
                    .baseButtonStyle(isProminent: false)
            }
            .padding(.horizontal)
        }
    }
}
