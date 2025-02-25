import PUI
import SwiftUI
import Models

public struct PlantCollectionView: View {
    public var body: some View {
        ScrollView(.vertical) {
            
            ScrollView(.horizontal) {
                Group {
                    
                    
                }
                
                
                
            }
            
            // watering view
            
            // photo gallery view
            
            
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("My plants")
                    .font(PUI.Font.title)
                    .foregroundStyle(Color.pui.accent)
            }
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                PUI.IconButton(Image(systemName: "plus.square.fill"), action: {
                    print("hello")
                })
            }
        }
    }
}

struct PlantCell: View {
    let model: Plant
    let action: (String) -> Void
    
    var body: some View {
        VStack {
            PUI.Picture(model.mainImageUrl.flatMap { URL(string: $0) })
                .frame(width: 100, height: 100)
            Text(model.name)
                .font(PUI.Font.text)
                .foregroundStyle(Color.pui.textPrimary)
        }.onTapGesture {
            action(model.id)
        }
    }
}
