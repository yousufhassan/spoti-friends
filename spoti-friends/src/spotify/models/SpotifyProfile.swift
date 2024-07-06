import Foundation
import RealmSwift

/// Class representing a `SpotifyProfile` object.
///
/// - Parameters:
///   - spotifyId: The Spotify ID associated with this Spotify profile.
///   - spotifyUri: The Spotify unique resource identifier for this Spotify profile.
///   - displayName: The display name associated with this Spotify profile.
///   - image: The profile image for this Spotify profile.
///   - currentOrMostRecentTrack: The track last played (or currently playing)  by this Spotify profile.
class SpotifyProfile: Object {
    @Persisted(primaryKey: true) var spotifyId: String
    @Persisted var spotifyUri: String
    @Persisted var displayName: String
    @Persisted var image: String
    @Persisted var currentOrMostRecentTrack: CurrentOrMostRecentTrack?
    
    public func getSpotifyIdFromUri(spotifyUri: String) -> String {
        return spotifyUri.components(separatedBy: ":").last ?? ""
    }
    
//    override init() {
//        super.init()
//    }
    
//    init(spotifyId: String, spotifyUri: String, displayName: String, image: String,
//         currentOrMostRecentTrack: CurrentOrMostRecentTrack? = nil) {
//        super.init()
//        self.spotifyId = spotifyId
//        self.spotifyUri = spotifyUri
//        self.displayName = displayName
//        self.image = image
//        self.currentOrMostRecentTrack = currentOrMostRecentTrack
//    }
    
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


/// The `SpotifyResource` protocol ensures each abiding object has a well-defined spotifyUri attribute.
protocol SpotifyResource {
    var spotifyUri: String { get }
    var name: String { get }
}

/// This extensions defines the function that returns the `spotifyUri` for all `spotifyResource` objects.
extension SpotifyResource {
    /// Returns the `spotifyUri` for this `spotifyResource`.
    func getSpotifyUri() -> String {
        return self.spotifyUri  // might need to omit the 'self' if it binds itself to the `SpotifyProfile` object
    }
}

/// Object representing a user's current or most recent track that they played.
class CurrentOrMostRecentTrack: Object {
    @Persisted var timestamp: TimeInterval
    @Persisted var track: Track?
    @Persisted var playedWithinLastFifteenMinutes: Bool
    
    /// Returns `True` if the track was played within the last 15 minutes, `False` otherwise.
    /// We deem a track to be "playing now" if it was played within the last 15 minutes. That is how Spotify does it.
    func isTrackPlayingNow() -> Bool {
        return !hasFifteenMinutesPassed(since: self.timestamp)
    }
}

/// Object representing a Spotify Track.
class Track: Object, SpotifyResource {
    @Persisted var spotifyUri: String
    @Persisted var name: String
    @Persisted var artist: Artist?
    @Persisted var album: Album?
    @Persisted var context: TrackContext?
}

/// Object representing a Spotify Artist.
class Artist: Object, SpotifyResource {
    @Persisted var spotifyUri: String
    @Persisted var name: String
}

/// Object representing a Spotify Album.
class Album: Object, SpotifyResource {
    @Persisted var spotifyUri: String
    @Persisted var name: String
    @Persisted var image: String
}

/// Object representing a Spotify Track Content.
class TrackContext: Object, SpotifyResource {
    @Persisted var spotifyUri: String
    @Persisted var name: String
    @Persisted var type: ContextType
    
    /// The context which this track is being played in
    enum ContextType: String, PersistableEnum {
        case album
        case artist
        case playlist
        case show
    }
    
    func extractContextTypeFromUri() -> ContextType {
        let uriComponents = self.spotifyUri.split(separator: ":")
        var extractedType = ""
        if uriComponents.count >= 2 {
            extractedType = String(uriComponents[uriComponents.count - 2])
        }
        return ContextType(rawValue: extractedType) ?? .playlist
    }
}
