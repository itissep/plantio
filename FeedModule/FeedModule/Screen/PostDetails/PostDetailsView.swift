import SwiftUI
import PUI

public struct PostDetailsView: View {
    
    @StateObject private var viewModel: PostDetailsViewModel
    
    init(viewModel: PostDetailsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: PUI.Spacing.large) {
            ScrollView {
                VStack(alignment: .leading) {
                    PostView(model: viewModel.state.post)
                        .padding(.top, PUI.Spacing.small)
                    
                    Text("Comments")
                        .font(PUI.Font.text)
                        .foregroundStyle(Color.pui.accent)
                        .padding(.top, PUI.Spacing.large)
                    
                    if viewModel.state.comments.isEmpty {
                        Text("nothing yet")
                    } else {
                        ForEach(viewModel.state.comments, id: \.id) { comment in
                            CommentView(model: comment)
                        }
                    }
                }
            }
        }.toolbar {
            ToolbarItem(placement: .principal) {
                Text("Post")
                    .font(PUI.Font.title)
                    .foregroundStyle(Color.pui.accent)
            }
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                PUI.IconButton(Image(systemName: "square.and.pencil")) {
                    viewModel.handle(.onEdit)
                }
            }
        }
        .scrollIndicators(.hidden)
        .padding(.horizontal, PUI.Spacing.large)
        .onAppear { viewModel.handle(.onAppear) }
    }
}
