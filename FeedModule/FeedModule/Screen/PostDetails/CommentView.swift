import SwiftUI
import Models
import PUI

struct CommentView: View {
    let model: Comment
    
    var body: some View {
        VStack(alignment: .leading, spacing: PUI.Spacing.medium) {
            HStack(spacing: PUI.Spacing.small) {
                PUI.Picture(model.user.avatarUrl.flatMap { URL(string: $0) })
                Text(model.user.nickName)
            }
            
            Text(model.text)
        }
        .padding(PUI.Spacing.medium)
        .background {
            RoundedRectangle(cornerRadius: PUI.Constant.cornerRadius)
                .foregroundStyle(Color.pui.backgroundSecondary)
        }
    }
}
