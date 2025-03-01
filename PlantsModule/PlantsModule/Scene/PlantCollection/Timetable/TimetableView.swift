import SwiftUI
import PUI

struct TimetableView: View {
    @State var color: Color
    @State var weeks: [WeekModel]

    var body: some View {
        HStack(alignment: .top) {
            ScrollViewReader { proxy in
                HStack {
                    ScrollView(.horizontal) {
                        HStack(spacing: Defaults.spacing) {
                            ForEach(weeks) { week in
                                VStack(spacing: Defaults.spacing) {
                                    if week.days.count != Defaults.numberOfDays, !week.days.contains(where: { $0.date.isMonday() }) {
                                        Spacer()
                                            .frame(height: Defaults.extraHeight(for: week.days.count))
                                    }
                                
                                    ForEach(week.days) { day in
                                        RoundedRectangle(cornerRadius: Defaults.cornerRadius)
                                            .frame(width: Defaults.dayRectSide, height: Defaults.dayRectSide)
                                            .foregroundStyle(color.opacity(day.isWatered ? 1 : Defaults.offOpacity))
                                            .id(week == weeks.last ? "last" : "")
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
//                    .onChange(of: weeks) {
//                        withAnimation {
//                            proxy.scrollTo("last", anchor: .bottom)
//                        }
//                    }
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
    }
}

private extension TimetableView {
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
