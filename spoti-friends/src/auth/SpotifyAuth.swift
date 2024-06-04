import Foundation

/// Class that handles the Spotify Authorization Singleton.
class SpotifyAuth {
    /// Shared instance of the SpotifyAuth Singleton class.
    static let shared = SpotifyAuth()
    
    /// Constructs the authorization URL that is used to get user authorization.
    func constructAuthorizationURL() -> URLRequest? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = AuthConstants.host
        components.path = AuthConstants.path
        
        let codeChallenge = CodeChallenge.shared.generateCodeChallenge()
        var params = AuthConstants.authParams
        params["code_challenge"] = codeChallenge
        components.queryItems = params.map({URLQueryItem(name: $0.key, value: $0.value)})
        
        guard let url = components.url else { return nil }
        return URLRequest(url: url)
    }
    
    /// TODO
    func handleResponseUrl(_ url: URL) -> Void {
        do {
            guard let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false),
                  let queryItems = urlComponents.queryItems
            else { throw URLError(.badURL) }
            
            if (userGrantedAuthorization(queryItems)) {
                // Handle authorization granted flow
                let code = try getCodeFromQueryItems(queryItems)
                print("Authorized with code: " + code)
            }
            else {
                // Handle authorization denied flow
                print("denied")
            }
        } catch {
            printError("\(error)")
        }
    }
    
    /// Returns `true` if user granted authorization to the application and response included the "code" value; `false`, otherwise.
    private func userGrantedAuthorization(_ queryItems: [URLQueryItem]) -> Bool {
        return queryItems.contains(where: {$0.name == "code"})
    }
    
    private func getCodeFromQueryItems(_ queryItems: [URLQueryItem]) throws -> String {
        guard let code = queryItems.first(where: { $0.name == "code" })?.value else { throw AuthorizationError.cannotExtractCode }
        print(code)
        return code
    }
}


/// Constants related to Spotify Authorization
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
