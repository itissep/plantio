import SwiftUI
import Models
import PUI

struct PostView: View {
    let post: Post
    
    var body: some View {
        VStack(alignment: .leading, spacing: PUI.Spacing.medium) {
            Text(post.title)
            Text(post.text)
        }
    }
}
