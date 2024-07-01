import Foundation

/// This extension adds functionality related to the `getCurrentUsersProfile` endpoint.
extension SpotifyAPI {
    internal func convertDataToSpotifyProfile(_ data: Data) throws -> SpotifyProfile {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            if let dataDict = jsonObject as? [String: Any] {
                
                let spotifyProfile = SpotifyProfile();
                spotifyProfile.spotifyId = dataDict["id"] as! String
                spotifyProfile.spotifyUri = dataDict["uri"] as! String
                spotifyProfile.displayName = dataDict["display_name"] as! String
                
                let image = getSpotifyImageFromResponseData(dataDict)
                spotifyProfile.image = getUrlAsStringFromSpotifyImage(image)
                return spotifyProfile
            }
            throw URLError(.badServerResponse)
        } catch {
            printError("\(error)")
            throw error
        }
    }
    
    /// Returns the url for the `SpotifyImage` as a String.
    internal func getUrlAsStringFromSpotifyImage(_ image: SpotifyImage) -> String {
        return image.url
    }
    
    /// Parses the API response object and returns the `SpotifyImage`
    internal func getSpotifyImageFromResponseData(_ data: [String : Any]) -> SpotifyImage {
        let image = ((data["images"] as! NSArray)[1]) as! Dictionary<String, Any>
        let spotifyImage = SpotifyImage(url: image["url"] as! String, height: image["height"] as! Int, width: image["width"] as! Int)
        return spotifyImage
    }
}

/// The object structure of images from Spotify.
struct SpotifyImage {
    let url: String
    let height: Int
    let width: Int
    
    init(url: String, height: Int, width: Int) {
        self.url = url
        self.height = height
        self.width = width
    }
}
