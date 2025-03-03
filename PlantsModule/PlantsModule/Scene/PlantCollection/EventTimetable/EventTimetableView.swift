import SwiftUI
import PUI

public struct EventTimetableView: View {
    
    @StateObject var viewModel: PlantCollectionViewModel

    let color: Color = .pui.accent
    let title: String = "watering"
    let actionTitle: String = "water me"
    let onActionTap: () -> Void
    
    var hasToday: Bool {
        var result: Bool = false
        viewModel.state.plantEvents.forEach { week in
            if week.days.contains(
                where: { Date.isOneDay(.now, secondDate:  $0.date) && $0.isWatered }
            ) { result = true }
        }
        return result
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: PUI.Spacing.medium) {
            HStack(spacing: PUI.Spacing.medium) {
                Text(title)
                    .foregroundStyle(Color.pui.textPrimary)
                    .font(PUI.Font.title)
            }
            
            HStack(alignment: .top) {
                ScrollViewReader { proxy in
                    HStack {
                        ScrollView(.horizontal) {
                            HStack(spacing: Defaults.spacing) {
                                ForEach(viewModel.state.plantEvents) { week in
                                    VStack(spacing: Defaults.spacing) {
                                        if week.days.count != Defaults.numberOfDays, !week.days.contains(where: { $0.date.isMonday() }) {
                                            Spacer()
                                                .frame(height: Defaults.extraHeight(for: week.days.count))
                                        }
                                        ForEach(week.days) { day in
                                            RoundedRectangle(cornerRadius: Defaults.cornerRadius)
                                                .frame(width: Defaults.dayRectSide, height: Defaults.dayRectSide)
                                                .foregroundStyle(color.opacity(day.isWatered ? 1 : Defaults.offOpacity))
                                                .id(week == viewModel.state.plantEvents.last ? "last" : "")
                                        }
                                        if week.days.count != Defaults.numberOfDays, week.days.contains(where: { $0.date.isMonday() }) {
                                            Spacer()
                                                .frame(height: Defaults.extraHeight(for: week.days.count))
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.vertical, PUI.Spacing.large)
                        .scrollIndicators(.hidden)
                        .scaleEffect(x: -1, y: 1)
                    }
                }
                VStack(spacing: Defaults.spacing) {
                    ForEach(Defaults.weekdays, id: \.self) { weekday in
                        Text(weekday)
                            .font(.system(size: Defaults.fontSize))
                            .foregroundStyle(Color.pui.textSecondary)
                            .monospaced()
                            .frame(height: Defaults.dayRectSide)
                    }
                }.padding(.vertical, PUI.Spacing.large)
            }
            
            HStack {
                Button(actionTitle) {
                    onActionTap()
                }.buttonStyle(PUI.BaseButtonStyle(
                    isProminent: true,
                    color: color
                )).disabled(hasToday)
                
                // TODO: add date picker
//                Button(action: {
//                    viewModel.onDatePickerTap()
//                }, label: {
//                    Image(systemName: "calendar.badge.plus")
//                        .foregroundStyle(viewModel.color)
//                        .bold()
//                        .font(.system(size: 30))
//                })
//                .frame(width: 50)
            }
        }.onAppear {
            print("reloaded")
        }
    }
    
    enum Defaults {
        static let spacing: CGFloat = 2
        static let cornerRadius: CGFloat = 5
        static let dayRectSide: CGFloat = 20
        
        static let fontSize: CGFloat = 10
        
        static let offOpacity: CGFloat = 0.3
        
        static let weekdays = ["mon", "tue", "wed", "thu", "fri", "sat", "sun"]
        
        static let numberOfDays = 7
        
        static func extraHeight(for days: Int) -> CGFloat {
            let hiddenBlocks = Defaults.numberOfDays - days
            let spacings = CGFloat(hiddenBlocks - 1) * Defaults.spacing
            let blocksHeght = CGFloat(hiddenBlocks) * Defaults.dayRectSide
            return blocksHeght + spacings
        }
    }
}
