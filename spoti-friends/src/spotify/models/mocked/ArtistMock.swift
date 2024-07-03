import Foundation

/// Struct containing mock Artist objects.
struct ArtistMock {
    static let zachBryan = createMockArtist(name: "Zach Bryan")
    static let oliviaRodrigo = createMockArtist(name: "Olivia Rodrigo")
    static let jonBellion = createMockArtist(name: "Jon Bellion")
}

private func createMockArtist(spotifyUri: String = "", name: String) -> Artist {
    let artist = Artist()
    artist.spotifyUri = spotifyUri
    artist.name = name
    return artist
}

