import Foundation


/// Spotify Access Token Response Object
struct AccessTokenResponse: Codable {
    /// An access token that can be provided in subsequent calls, for example to Spotify Web API services.
    let access_token: String
    
    /// How the access token may be used: always "Bearer".
    let token_type: String
    
    /// A space-separated list of scopes which have been granted for this access_token
    let scope: String
    
    /// The time period (in seconds) for which the access token is valid.
    let expires_in: Int
    
    /// The refresh token to be used to obtain new access tokens.
    let refresh_token: String
}
