import SwiftUI
import PUI

public struct FeedView: View {

    @StateObject private var viewModel: FeedViewModel

    init(viewModel: FeedViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    public var body: some View {
        VStack(spacing: PUI.Spacing.large) {
            HStack(spacing: PUI.Spacing.medium) {
                Spacer()
                PUI.IconButton(Image(systemName: "square.and.pencil")) {
                    viewModel.handle(.onAddPostTapped)
                }
            }
            ScrollView {
                if viewModel.state.posts.isEmpty {
                    Text("nothing yet")
                } else {
                    ForEach(viewModel.state.posts, id: \.id) { post in
                        PostView(post: post)
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
        .padding(.horizontal, PUI.Spacing.large)
        .onAppear { viewModel.handle(.onAppear) }
    }
}
