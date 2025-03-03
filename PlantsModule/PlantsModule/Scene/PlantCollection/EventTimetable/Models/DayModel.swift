import Foundation

struct DayModel: Identifiable, Equatable, Hashable {
    let id = UUID()
    let date: Date
    let isWatered: Bool
}
