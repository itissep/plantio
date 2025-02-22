import SwiftUI
import Models
import PUI

struct PostView: View {
    let model: Post
    
    var body: some View {
        VStack(alignment: .leading, spacing: PUI.Spacing.large) {
            HStack {
                PUI.Picture(model.user.avatarUrl.flatMap { URL(string: $0) ?? nil })
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
                    .clipped()
                    
                VStack(alignment: .leading, spacing: PUI.Spacing.small) {
                    Text(model.user.nickName)
                        .font(PUI.Font.text)
                        .foregroundStyle(Color.pui.textPrimary)
                    Text(model.createdAt.formattedAsDateTime())
                        .font(PUI.Font.caption)
                        .foregroundStyle(Color.pui.textPrimary)
                }
                Spacer()
            }
            Text(model.title)
                .font(PUI.Font.title)
                .foregroundStyle(Color.pui.textPrimary)
            
            Text(model.text)
                .foregroundStyle(Color.pui.textPrimary)
        
            
        }
        .padding(PUI.Spacing.large)
        .background {
            RoundedRectangle(cornerRadius: PUI.Constant.cornerRadius)
                .foregroundStyle(Color.pui.backgroundSecondary)
        }
            
    }
}
