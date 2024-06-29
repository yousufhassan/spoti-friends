import Foundation
import UIImageColors
import SwiftUI

/// Returns the accent color for an image at the URL passed in, or white by default.
///
/// - Parameters:
///   - imageURLAsString: The string value for the image URL.
///
/// - Returns: The the accent color of the image as a `UIColor` or white as a default.
public func getAccentColorForImage(_ imageURLAsString: String) async throws -> UIColor {
    guard let imageURL = URL(string: imageURLAsString) else { return UIColor(.white) }
    let request = URLRequest(url: imageURL)
    let (data, _) = try await URLSession.shared.data(for: request)
    
    let image = UIImage(data: data)
    let accentColor = image!.getColors()?.detail
    return accentColor ?? UIColor(.white)
}
