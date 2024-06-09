import Foundation
import RealmSwift

/// Class representing a `SpotifyProfile` object.
class SpotifyProfile: Object {
    @Persisted(primaryKey: true) var spotifyId: String
    @Persisted var spotifyUri: String
    @Persisted var displayName: String
    @Persisted var image: String
    @Persisted var currentOrMostRecentTrack: CurrentOrMostRecentTrack?
    
    init(spotifyId: String, spotifyUri: String, displayName: String, image: String,
         currentOrMostRecentTrack: CurrentOrMostRecentTrack? = nil) {
        super.init()
        self.spotifyId = spotifyId
        self.spotifyUri = spotifyUri
        self.displayName = displayName
        self.image = image
        self.currentOrMostRecentTrack = currentOrMostRecentTrack
    }
    
    // List of methods
    //    getSpotifyId()
    //    getUsersProfileFromSpotifyId(spotifyId)  // Spotify Web API call
    //
    //    getSpotifyUri()
    //    getDisplayName()
    //    getImage()
    //
    //    getCurrentOrMostRecentTrack()
    //    refreshCurrentOrMostRecentTrack() // API call
}


// Protocol ensures each abiding object has a well-defined spotifyUri attribute (like an abstract class)
protocol SpotifyResource {
    var spotifyUri: String { get }
}

extension SpotifyResource {
    func getSpotifyUri() -> String {
        return self.spotifyUri  // might need to omit the 'self' if it binds itself to the `SpotifyProfile` object
    }
}

class CurrentOrMostRecentTrack: Object {
    @Persisted var timestamp: TimeInterval
    @Persisted var track: Track
}

class Track: Object, SpotifyResource {
    @Persisted var spotifyUri: String
    @Persisted var name: String
    @Persisted var artist: Artist
    @Persisted var album: Album
    @Persisted var context: Context
}

class Artist: Object, SpotifyResource {
    @Persisted var spotifyUri: String
    @Persisted var name: String
}

class Album: Object, SpotifyResource {
    @Persisted var spotifyUri: String
    @Persisted var image: String
}

class Context: Object, SpotifyResource {
    @Persisted var spotifyUri: String
    @Persisted var name: String
}
