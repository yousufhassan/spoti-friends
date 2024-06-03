import Foundation

/// Class that handles the Spotify Authorization
class SpotifyAuth {
    static let shared = SpotifyAuth()
    
//    func requestUserAuthorization() {
//        let url = getAuthorizationURL()
//
//    }
    
    func getAuthorizationURL() -> URLRequest? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = AuthConstants.host
        components.path = AuthConstants.path
        
        let codeChallenge = CodeChallenge.shared.generateCodeChallenge()
        var params = AuthConstants.authParams
        params["code_challenge"] = codeChallenge
        components.queryItems = params.map({URLQueryItem(name: $0.key, value: $0.value)})

        
        guard let url = components.url else { return nil }
        print(url.absoluteString)
        return URLRequest(url: url)
    }
}


private enum AuthConstants {
    static let host = "accounts.spotify.com"
    static let path = "/authorize"
    static let responseType = "code"
    static let clientId = "c65f0c16a79c47688a0fc72f6eaf1636"
    static let scopes = "user-read-private user-read-email"
    static let codeChallengeMethod = "S256"
    static let redirectUri = "spoti-friends://spotify-login-callback"
    
    static var authParams = [
        "response_type": responseType,
        "client_id": clientId,
        "scope": scopes,
        "code_challenge_method": codeChallengeMethod,
        "redirect_uri": redirectUri,
    ]
    
}
