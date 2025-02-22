import Foundation

public extension Date {

    func formatted(as format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

    /// dd.MM.yyyy
    func formattedAsShortDate() -> String {
        formatted(as: "dd.MM.yyyy")
    }

    /// dd MMMM yyyy
    func formattedAsLongDate() -> String {
        formatted(as: "dd MMMM yyyy")
    }

    /// HH:mm
    func formattedAsTime() -> String {
        formatted(as: "HH:mm")
    }

    /// HH:mm dd.MM.yyyy
    func formattedAsDateTime() -> String {
        formatted(as: "HH:mm dd.MM.yyyy")
    }
}
