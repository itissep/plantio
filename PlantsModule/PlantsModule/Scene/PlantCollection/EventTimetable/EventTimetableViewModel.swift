import SwiftUI

struct EventTimetableViewModel: Equatable {
    static func == (lhs: EventTimetableViewModel, rhs: EventTimetableViewModel) -> Bool {
        lhs.color == rhs.color
        && lhs.title == rhs.title
        && lhs.weeks == rhs.weeks
        && lhs.actionTitle == rhs.actionTitle
    }
    
    let color: Color
    let title: String
    let weeks: [WeekModel]
    let actionTitle: String
    
    let onActionTap: () -> Void
//    let onDatePickerTap: () -> Void
}
