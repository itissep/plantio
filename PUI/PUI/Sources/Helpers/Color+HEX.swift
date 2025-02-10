import Foundation
import SwiftUI

extension Color {
    init?(hex: String, alpha: Double = 1.0) {
        let r, g, b: Double
        var alpha = alpha
        
        // Remove the hash at the start if it's there
        let start = hex.hasPrefix("#") ? hex.index(hex.startIndex, offsetBy: 1) : hex.startIndex
        
        // Get the hex substring
        let hexColor = String(hex[start...])
        
        var rgb: UInt64 = 0
        
        // Scan the hex string to an unsigned integer
        Scanner(string: hexColor).scanHexInt64(&rgb)
        
        // Extract RGB components
        switch hexColor.count {
        case 6: // RGB
            r = Double((rgb >> 16) & 0xFF) / 255.0
            g = Double((rgb >> 8) & 0xFF) / 255.0
            b = Double(rgb & 0xFF) / 255.0
        case 8: // RGBA
            r = Double((rgb >> 24) & 0xFF) / 255.0
            g = Double((rgb >> 16) & 0xFF) / 255.0
            b = Double((rgb >> 8) & 0xFF) / 255.0
            alpha = Double(rgb & 0xFF) / 255.0
        default:
            return nil // Invalid hex string length
        }
        
        self.init(red: r, green: g, blue: b, opacity: alpha)
    }
}
