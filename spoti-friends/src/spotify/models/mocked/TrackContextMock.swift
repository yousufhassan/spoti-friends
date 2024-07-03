import Foundation

/// Struct containing mock TrackContext objects.
struct TrackContextMock {
    static let playlistAllMySongs = createMockTrackContext(name: "all my songs")
    static let albumSour = createMockTrackContext(name: "SOUR")
    static let artistJonBellion = createMockTrackContext(name: "Jon Bellion")
}

private func createMockTrackContext(spotifyUri: String = "", name: String) -> TrackContext {
    let context = TrackContext()
    context.spotifyUri = spotifyUri
    context.name = name
    return context
}

