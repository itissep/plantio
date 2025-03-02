import SwiftUI
import Models
import PUI
import Core

struct PhotoGridView: View {
    let urlStrings: [PhotoModel]
    
    let lastItemIcon: Image
    let onPlantTap: (Data) -> Void
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
            ForEach(urlStrings, id: \.id) { item in
                ZStack(alignment: .bottomTrailing) {
                    GeometryReader { geometry in
                        PUI.Picture(nil, data: item.imageData)
                            .frame(height: geometry.size.width)
                            .onLongPressGesture {
                                onPlantTap(item.imageData)
                            }
                    }
                    .aspectRatio(1, contentMode: .fit)
                    .clipShape(.rect(cornerRadius: PUI.Constant.cornerRadius))
                    
                    Text(item.createdAt.formattedAsLongDate())
                        .font(PUI.Font.caption)
                        .padding(.all, PUI.Spacing.small)
                        .background {
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundStyle(Color.pui.backgroundPrimary)
                        }
                        .padding(.all, PUI.Spacing.small)
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
