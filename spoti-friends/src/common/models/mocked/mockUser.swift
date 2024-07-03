import Foundation
import SwiftUI

struct mockUser {
    let object = getMockUser()
    
    static func getMockUser() -> User {
        let user = User()
        user.spotifyId = "mockSpotifyId"

        let profile = SpotifyProfile()
        profile.spotifyId = "mockProfileId"
        profile.spotifyUri = "spotify:mock:profile"
        profile.displayName = "Mock User"
        profile.image = "mockImageURL"
        user.spotifyProfile = profile

        let friend1 = SpotifyProfile()
        friend1.spotifyId = "friend1Id"
        friend1.spotifyUri = "spotify:friend1"
        friend1.displayName = "Friend 1"
        friend1.image = "friend1ImageURL"

        let friend2 = SpotifyProfile()
        friend2.spotifyId = "friend2Id"
        friend2.spotifyUri = "spotify:friend2"
        friend2.displayName = "Friend 2"
        friend2.image = "friend2ImageURL"

        user.friends.append(objectsIn: [friend1, friend2])

        user.authorizationCode = "mockAuthCode"

//        let webAccessToken = SpotifyWebAccessToken()
//        let internalToken = InternalAPIAccessToken()
//        let cookie = SpDcCookie()

        return user
    }
}

struct MockData {
    let object = createMockListeningActivityItem()
    
    static func createMockAlbum() -> Album {
        let album = Album()
        album.spotifyUri = "spotify:album:mockAlbum"
        album.name = "Mock Album"
        album.image = "mockAlbumImageURL"
        return album
    }

    static func createMockTrack() -> CurrentOrMostRecentTrack {
        let track = CurrentOrMostRecentTrack()
        track.timestamp = 1719827945

        let trackDetails = Track()
        trackDetails.spotifyUri = "spotify:track:mockTrack"
        trackDetails.name = "Mock Track"
        
        let artist = Artist()
        artist.spotifyUri = "spotify:artist:mockArtist"
        artist.name = "Mock Artist"
        trackDetails.artist = artist

        track.track = trackDetails
        return track
    }

    static func createMockListeningActivityItem() -> ListeningActivityItem {
        return ListeningActivityItem(
            spotifyId: "mockSpotifyId",
            album: createMockAlbum(),
            username: "Mock User",
            track: createMockTrack(),
            backgroundColor: Color.blue
        )
    }
}

