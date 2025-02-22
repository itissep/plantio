import SwiftUI
import PUI

public struct FeedView: View {
    
    @StateObject private var viewModel: FeedViewModel
    
    init(viewModel: FeedViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        ScrollView {
            VStack(spacing: PUI.Spacing.large) {
                if viewModel.state.posts.isEmpty {
                    Text("nothing yet")
                } else {
                    ForEach(viewModel.state.posts, id: \.id) { post in
                        PostView(model: post)
                            .onTapGesture {
                                viewModel.handle(.onPostSelectWithId(post.id))
                            }
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Feed")
                    .font(PUI.Font.title)
                    .foregroundStyle(Color.pui.accent)
                
            }
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                PUI.IconButton(Image(systemName: "square.and.pencil")) {
                    viewModel.handle(.onAddPostTapped)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .scrollIndicators(.hidden)
        .padding(.horizontal, PUI.Spacing.large)
        .onAppear { viewModel.handle(.onAppear) }
    }
}
