import SwiftUI
import Models
import PUI

struct CommentView: View {
    let model: Comment
    
    var body: some View {
        VStack(alignment: .leading, spacing: PUI.Spacing.medium) {
            HStack(spacing: PUI.Spacing.small) {
                PUI.Picture(model.user.avatarUrl.flatMap { URL(string: $0) ?? nil })
                    .frame(width: 20, height: 20)
                    .clipShape(Circle())
                    .clipped()
            
                    Text(model.user.nickName)
                        .font(PUI.Font.caption)
                        .foregroundStyle(Color.pui.textPrimary)
                Spacer()
                    Text(model.createdAt.formattedAsDateTime())
                        .font(PUI.Font.caption)
                        .foregroundStyle(Color.pui.textPrimary)
            }
            
            Text(model.text)
                .font(PUI.Font.text)
                .foregroundStyle(Color.pui.textPrimary)
        }
        .padding(PUI.Spacing.large)
        .background {
            RoundedRectangle(cornerRadius: PUI.Constant.cornerRadius)
                .foregroundStyle(Color.pui.backgroundSecondary)
        }
    }
}
