import Foundation

/// Returns `true` if 15 minutes or more have passed since `timeInterval` and `false` otherwise.
func hasFifteenMinutesPassed(since timeInterval: TimeInterval) -> Bool {
    let pastDate = Date(timeIntervalSince1970: timeInterval)
    let currentDate = Date()
    let difference = currentDate.timeIntervalSince(pastDate)
    
    let fifteenMinutes: TimeInterval = 15 * 60
    return difference >= fifteenMinutes
}

/// Returns the relative time that has elapsed since `timestamp`.
///
/// - Parameters:
///   - timestamp: The timestamp in seconds
///
/// Examples:
///   - 25m
///   - 1h
///   - 3d
func getRelativeTime(since timestamp: TimeInterval) -> String {
    let pastDate = Date(timeIntervalSince1970: timestamp)
    let currentDate = Date()
    let difference = currentDate.timeIntervalSince(pastDate)
    
    // Calculate the time components
    let seconds = Int(difference)
    let minutes = seconds / 60
    let hours = (minutes + 30) / 60 // rounds to the nearest hour, up or down
    let days = hours / 24
    
    // Determine the appropriate relative time string
    if days > 0 {
        return "\(days)d"
    } else if hours > 0 {
        return "\(hours)h"
    } else if minutes > 0 {
        return "\(minutes)m"
    } else {
        return "\(seconds)s"
    }
}
