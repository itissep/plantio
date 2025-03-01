import Foundation

struct DayModel: Identifiable, Hashable {
    let id = UUID()
    let date: Date
    let isWatered: Bool
}
