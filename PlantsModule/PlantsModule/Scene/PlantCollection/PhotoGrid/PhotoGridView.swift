import SwiftUI
import Models
import PUI

struct PhotoGridView: View {
    let urlStrings: [String]
    
    let lastItemIcon: Image
    let onPlantTap: (String) -> Void
    let lastItemAction: () -> Void
    
    var body: some View {
        LazyVGrid(
            columns:
                Array(
                    repeating: GridItem(.flexible(minimum: 100, maximum: 150), spacing: PUI.Spacing.large),
                    count: 3
                ),
            alignment: .leading,
            spacing: PUI.Spacing.large,
            pinnedViews: [.sectionHeaders, .sectionFooters]
        ) {
            ForEach(urlStrings, id: \.self) { urlString in
                Group {
                    if let url = URL(string: urlString) {
                        GeometryReader { geometry in
                            PUI.Picture(url)
                                .frame(height: geometry.size.width)
                        }
                        .aspectRatio(1, contentMode: .fit)
                        .clipShape(.rect(cornerRadius: PUI.Constant.cornerRadius))
                    } else {
                        RoundedRectangle(cornerRadius: PUI.Constant.cornerRadius)
                            .foregroundStyle(Color.pui.accent)
                            .aspectRatio(1, contentMode: .fit)
                    }
                }
            }
            RoundedRectangle(cornerRadius: PUI.Constant.cornerRadius)
                .foregroundStyle(Color.pui.accent.opacity(0.5))
                .aspectRatio(1, contentMode: .fit)
                .overlay {
                    lastItemIcon
                        .foregroundStyle(Color.pui.backgroundSecondary)
                        .font(.system(size: 100))
                }.onTapGesture {
                    lastItemAction()
                }
        }
    }
}
