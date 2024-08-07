import Foundation

/// Struct containing mock Track objects.
struct TrackMock {
    static let iRememberEverything = createMockTrack(spotifyUri: "spotify:track:4KULAymBBJcPRpk1yO4dOG",
                                                     name: "I Remember Everything (feat. Kacey Musgraves)",
                                                     artist: ArtistMock.zachBryan,
                                                     album: AlbumMock.zachBryan,
                                                     context: TrackContextMock.playlistAllMySongs)
    
    static let traitor = createMockTrack(spotifyUri: "spotify:track:5CZ40GBx1sQ9agT82CLQCT",
                                         name: "traitor", artist: ArtistMock.oliviaRodrigo,
                                         album: AlbumMock.sour, context: TrackContextMock.albumSour)
    
    static let luxury = createMockTrack(spotifyUri: "spotify:track:5CgFGKdTn8R5dXGEPEX6Gm",
                                        name: "Luxury", artist: ArtistMock.jonBellion,
                                        album: AlbumMock.theDefinition, context: TrackContextMock.artistJonBellion)
    
    static func createMockTrack(spotifyUri: String = "", name: String, artist: Artist, album: Album, context: TrackContext) -> Track {
        let track = Track()
        track.spotifyUri = spotifyUri
        track.name = name
        track.artist = artist
        track.album = album
        track.context = context
        return track
    }

}

/// Struct containing mock CurrentOrMostRecentTrack objects.
struct CurrentOrMostRecentTrackMock {
    static let iRememberEverything = createMockCurrentOrMostRecentTrack(timestamp: 1720151150,
                                                                        track: TrackMock.iRememberEverything)
    static let traitor = createMockCurrentOrMostRecentTrack(timestamp: 1720151150,
                                                            track: TrackMock.traitor)
    
    static let luxury = createMockCurrentOrMostRecentTrack(timestamp: 1720074752,
                                                           track: TrackMock.luxury)
     
    static func createMockCurrentOrMostRecentTrack(timestamp: TimeInterval, track: Track) -> CurrentOrMostRecentTrack {
        let currTrack = CurrentOrMostRecentTrack()
        currTrack.timestamp = timestamp
        currTrack.track = track
        currTrack.playedWithinLastFifteenMinutes = currTrack.isTrackPlayingNow()
        return currTrack
    }

}
