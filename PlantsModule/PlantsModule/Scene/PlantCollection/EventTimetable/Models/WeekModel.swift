import Foundation

struct WeekModel: Identifiable, Equatable, Hashable {
    static func == (lhs: WeekModel, rhs: WeekModel) -> Bool {
        lhs.id == rhs.id && lhs.days == rhs.days
    }
    
    let id = UUID()
    let days: [DayModel]
}
