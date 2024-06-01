import Foundation
import SwiftUI

extension Color {
    struct PresetColour {
        static var spotifyGreen: Color { return Color(red: 0.11, green: 0.72, blue: 0.33)}
        static var white: Color { return Color(red: 0.94, green: 0.94, blue: 0.94)}
        static var black: Color { return Color(red: 0.03, green: 0.03, blue: 0.03)}
        static var darkgrey: Color { return Color(red: 0.13, green: 0.13, blue: 0.13)}
    }
    
    struct PresetGradient {
        static var mainDarkGradient: Gradient {return  Gradient(colors: [Color(red: 0.12, green: 0.12, blue: 0.12), Color(red: 0.06, green: 0.06, blue: 0.06)])}
    }
}
