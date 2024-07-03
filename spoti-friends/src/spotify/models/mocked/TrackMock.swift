import Foundation

/// Struct containing mock Track objects.
struct TrackMock {
    static let iRememberEverything = createMockTrack(name: "I Remember Everything (feat. Kacey Musgraves)",
                                                     artist: ArtistMock.zachBryan,
                                                     album: AlbumMock.zachBryan,
                                                     context: TrackContextMock.playlistAllMySongs)
    
    static let traitor = createMockTrack(name: "traitor", artist: ArtistMock.oliviaRodrigo,
                                         album: AlbumMock.sour, context: TrackContextMock.albumSour)
    
    static let luxury = createMockTrack(name: "Luxury", artist: ArtistMock.jonBellion,
                                        album: AlbumMock.theDefinition, context: TrackContextMock.artistJonBellion)
    
}

private func createMockTrack(spotifyUri: String = "", name: String, artist: Artist, album: Album, context: TrackContext) -> Track {
    let track = Track()
    track.spotifyUri = spotifyUri
    track.name = name
    track.artist = artist
    track.album = album
    track.context = context
    return track
}

/// Struct containing mock CurrentOrMostRecentTrack objects.
struct CurrentOrMostRecentTrackMock {
    static let iRememberEverything = createMockCurrentOrMostRecentTrack(timestamp: Date.timeIntervalSinceReferenceDate,
                                                                        track: TrackMock.iRememberEverything)
    static let traitor = createMockCurrentOrMostRecentTrack(timestamp: Date.timeIntervalSinceReferenceDate,
                                                            track: TrackMock.traitor)
    
    static let luxury = createMockCurrentOrMostRecentTrack(timestamp: Date.timeIntervalSinceReferenceDate,
                                                           track: TrackMock.luxury)
    
}

private func createMockCurrentOrMostRecentTrack(timestamp: TimeInterval, track: Track) -> CurrentOrMostRecentTrack {
    let currTrack = CurrentOrMostRecentTrack()
    currTrack.timestamp = timestamp
    currTrack.track = track
    return currTrack
}
