import SwiftUI
import PUI

public struct PostDetailsView: View {

    @StateObject private var viewModel: PostDetailsViewModel

    init(viewModel: PostDetailsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    public var body: some View {
        VStack(spacing: PUI.Spacing.large) {
            HStack(spacing: PUI.Spacing.medium) {
                Spacer()
                PUI.IconButton(Image(systemName: "square.and.pencil")) {
                    viewModel.handle(.onEdit)
                }
            }
            ScrollView {
                PostView(post: viewModel.state.post)
                
                if viewModel.state.comments.isEmpty {
                    Text("nothing yet")
                } else {
                    ForEach(viewModel.state.comments, id: \.id) { comment in
                        CommentView(model: comment)
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
        .padding(.horizontal, PUI.Spacing.large)
        .onAppear { viewModel.handle(.onAppear) }
    }
}
