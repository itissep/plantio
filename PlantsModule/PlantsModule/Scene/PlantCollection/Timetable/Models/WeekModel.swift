import Foundation

struct WeekModel: Identifiable, Equatable, Hashable {
    static func == (lhs: WeekModel, rhs: WeekModel) -> Bool {
        lhs.id == rhs.id
    }
    
    let id = UUID()
    let days: [DayModel]
}
