import SwiftUI
import PUI

public struct EventTimetableView: View {
    @State var viewModel: EventTimetableViewModel
    
    public var body: some View {
        VStack(alignment: .leading, spacing: PUI.Spacing.medium) {
            HStack(spacing: PUI.Spacing.medium) {
                Text(viewModel.title)
                    .foregroundStyle(Color.pui.textPrimary)
                    .font(PUI.Font.title)
            }
            TimetableView(color: viewModel.color)
            
            HStack {
                Button(viewModel.actionTitle) {
                    viewModel.onActionTap()
                }.buttonStyle(PUI.BaseButtonStyle(isProminent: true, color: viewModel.color))
                
                Button(action: {
                    viewModel.onDatePickerTap()
                }, label: {
                    Image(systemName: "calendar.badge.plus")
                        .foregroundStyle(viewModel.color)
                        .bold()
                        .font(.system(size: 30))
                })
                .frame(width: 50)
            }
        }
    }
}

