import Foundation
import RealmSwift

/// Class representing a User of the application.
class User: Object {
    @Persisted(primaryKey: true) var _id: UUID
//    var spotifyProfile: SpotifyProfile
//    var friends: List<SpotifyProfile>
    @Persisted var authorizationCode: String?
    @Persisted var spotifyWebAccessToken: SpotifyWebAccessToken?
    @Persisted var authorizationStatus: AuthorizationStatus
    @Persisted var spDcCookie: SpDcCookie?
    
    override init() {
        super.init()
        self._id = UUID()
//        self.spotifyProfile = SpotifyProfile(...)  // dummy function for example
//        self.friends = self.getFriendList(...)  // dummy function for example
        self.authorizationCode = nil
        self.spotifyWebAccessToken = nil
        self.authorizationStatus = .unauthenticated
        self.spDcCookie = nil
    }
    
    /// Sets the user's `authorizationCode`.
    public func setAuthorizationCode(_ code: String) -> Void {
        self.authorizationCode = code
    }
    
    /// Sets the user's `spotifyWebAccessToken`.
    public func setSpotifyWebAccessToken(_ spotifyWebAccessToken: SpotifyWebAccessToken) -> Void {
        self.spotifyWebAccessToken = spotifyWebAccessToken
    }
    
    /// Sets the user's `authorizationStatus` as `status`.
    public func setAuthorizationStatusAs(_ status: AuthorizationStatus) -> Void {
        self.authorizationStatus = status
    }
    
    /// Sets the spDcCookie.
    public func setSpDcCookie(_ cookie: SpDcCookie) {
        let realm = try! Realm()
        try! realm.write {
            self.spDcCookie = cookie
        }
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

