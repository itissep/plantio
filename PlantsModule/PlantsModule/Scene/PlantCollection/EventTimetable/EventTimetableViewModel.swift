import SwiftUI

struct EventTimetableViewModel {
    let color: Color
    let title: String
    let weeks: [WeekModel]
    let actionTitle: String
    
    let onActionTap: () -> Void
    let onDatePickerTap: () -> Void
}
