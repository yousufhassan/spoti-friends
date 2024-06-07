import Foundation
import RealmSwift

/// Class representing a User of the application.

// Commenting out because it turns properties into computed properties which cannot be marked with @Persisted
//@Observable
class User: Object {
    @Persisted(primaryKey: true) var _id: UUID
//    var spotifyProfile: SpotifyProfile
//    var friends: List<SpotifyProfile>
//    var spDcCookie: String
    @Persisted var spotifyWebAccessToken: SpotifyWebAccessToken?
    @Persisted var authorizationCode: String?
    @Persisted var authorizationStatus: AuthorizationStatus
    
    override init() {
        super.init()
        self._id = UUID()
//        self.spotifyProfile = SpotifyProfile(...)  // dummy function for example
//        self.friends = self.getFriendList(...)  // dummy function for example
//        self.spDcCookie = ""
        self.spotifyWebAccessToken = nil
        self.authorizationCode = nil
        self.authorizationStatus = .unauthenticated
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


/// The user's status for granting the application authorization.
///
/// `unauthenticated` when the user has not granted nor denied authorization and will need to make a choice.
///
/// `granted` when the user has granted authorization and can use the application normally.
///
/// `denied` when the user has denied authorization and will not be able to use the application.
enum AuthorizationStatus: String, PersistableEnum {
    /// The user has not granted nor denied authorization and will need to make a choice.
    case unauthenticated
    /// The user has granted authorization and can use the application normally.
    case granted
    /// The user has denied authorization and will not be able to use the application.
    case denied
}

