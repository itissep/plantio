import PUI
import SwiftUI
import Models

public struct PlantCollectionView: View {
    
    public var body: some View {
        ScrollView {
            
            VStack(spacing: PUI.Spacing.large) {
                EventTimetableView(viewModel: EventTimetableViewModel(color: .pui.accent, title: "title", weeks: [], actionTitle: "title", onActionTap: {
                    //
                }, onDatePickerTap: {
                    //
                }))
                
                EventTimetableView(viewModel: EventTimetableViewModel(color: .pui.accentButton, title: "title", weeks: [], actionTitle: "title", onActionTap: {
                    //
                }, onDatePickerTap: {
                    //
                }))
                
//                Text("photos")
//                    .foregroundStyle(Color.pui.textPrimary)
//                    .font(PUI.Font.title)
            }
        }
        .padding(.horizontal, PUI.Spacing.large)
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
