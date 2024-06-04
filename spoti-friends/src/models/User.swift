import Foundation

/// Class representing a User of the application.
class User {
    var _id: UUID
//    var spotifyProfile: SpotifyProfile
//    var friends: List<SpotifyProfile>
//    var spDcCookie: String
//    var webAccessToken: SpotifyWebAccessToken
    var authorizationCode: String
    
    init() {
        self._id = UUID()
//        self.spotifyProfile = SpotifyProfile(...)  // dummy function for example
//        self.friends = self.getFriendList(...)  // dummy function for example
//        self.spDcCookie = ""
        self.authorizationCode = ""
    }
    
    // List of methods to implement when the time comes
    //    getSpotifyProfile()
    //
    //    getFriendList()
    //    setFriendList()
    //
    //    isSpDcValid()
    //    setSpDcAsValid()
    //    setSpDcAsExpired()
}


//struct SpotifyWebAccessToken {
//    var token: String
//    var expiresAt: TimeInterval
//}
