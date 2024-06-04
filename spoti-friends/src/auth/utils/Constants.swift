import Foundation

// TODO: Refactor this enum; getting too large.
/// Constants related to Spotify Authorization
internal enum AuthConstants {
    static let host = "accounts.spotify.com"
    static let authorizePath = "/authorize"
    static let apiTokenPath = "/api/token"
    static let responseType = "code"
    static let clientId = "c65f0c16a79c47688a0fc72f6eaf1636"
    static let scopes = "user-read-private user-read-email"
    static let codeChallengeMethod = "S256"
    static let redirectUri = "spoti-friends://spotify-login-callback"
    static let grantType = "authorization_code"
    
    static var authorizationRequestParams = [
        "response_type": responseType,
        "client_id": clientId,
        "scope": scopes,
        "code_challenge_method": codeChallengeMethod,
        "code_challenge": "",  // will set at runtime
        "redirect_uri": redirectUri,
    ]
    
    static var accessTokenRequestParams = [
        "client_id": clientId,
        "grant_type": grantType,
        "code": "",  // will set at runtime
        "redirect_uri": redirectUri,
        "code_verifier": getStringFromUserDefaultsValueForKey("code_verifier"),
    ]
}
