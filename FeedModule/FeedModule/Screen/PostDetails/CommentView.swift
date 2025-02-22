import SwiftUI
import Models
import PUI

struct CommentView: View {
    let model: Comment
    
    var body: some View {
        VStack(alignment: .leading, spacing: PUI.Spacing.medium) {
            Text(model.user.nickName)
            Text(model.text)
        }
    }
}
