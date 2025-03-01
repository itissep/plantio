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

    init?(day: Int, month: Int, year: Int) {
        var components = DateComponents()
        components.day = day
        components.month = month
        components.year = year
        
        guard let date = Calendar.current.date(from: components) else {
            return nil
        }
        
        self = date
    }
    
    static func isOneDay(_ firstDate: Date, secondDate: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.component(.day, from: firstDate) == calendar.component(.day, from: secondDate)
        && calendar.component(.month, from: firstDate) == calendar.component(.month, from: secondDate)
        && calendar.component(.year, from: firstDate) == calendar.component(.year, from: secondDate)
    }
    
    static func date(day: Int, month: Int, year: Int) -> Date? {
        var components = DateComponents()
        components.day = day
        components.month = month
        components.year = year
        
        return Calendar.current.date(from: components)
    }
    
    func isMonday() -> Bool {
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: self)
        
        return weekday == 2 // В Gregorian календаре понедельник — это 2, если неделя начинается с воскресенья.
    }
}
