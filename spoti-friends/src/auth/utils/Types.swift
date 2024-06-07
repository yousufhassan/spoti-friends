import Foundation
import RealmSwift


/// Spotify Access Token Response Object
class SpotifyWebAccessToken: Object, Codable {
    /// An access token that can be provided in subsequent calls, for example to Spotify Web API services.
    @Persisted var access_token: String
    
    /// How the access token may be used: always "Bearer".
    @Persisted var token_type: String
    
    /// A space-separated list of scopes which have been granted for this access_token
    @Persisted var scope: String
    
    /// The time period (in seconds) for which the access token is valid.
    @Persisted var expires_in: Int
    
    /// The refresh token to be used to obtain new access tokens.
    @Persisted var refresh_token: String
}
