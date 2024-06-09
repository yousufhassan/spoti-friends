import Foundation
import CryptoKit
import RealmSwift

/// Class that handles the Spotify Authorization Singleton.
class SpotifyAuth {
    /// Shared instance of the SpotifyAuth Singleton class.
    static let shared = SpotifyAuth()
    
    /// Constructs the authorization URL that is used to get user authorization.
    func constructAuthorizationUrl() -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = AuthorizationConstants.host
        components.path = AuthorizationConstants.AuthorizationRequest.authorizePath
        
        var params = AuthorizationConstants.authorizationRequestParams
        let codeChallenge = CodeChallenge.shared.generateCodeChallenge()
        params["code_challenge"] = codeChallenge
        components.queryItems = params.map({URLQueryItem(name: $0.key, value: $0.value)})
        
        guard let url = components.url else { return nil }
        return url
    }
    
    /// Handles the response from the Spotify authorization flow depending on whether the user granted authorization or denied authorization.
    func handleResponseUrl(user: User, url: URL) async -> Void {
        do {
            guard let responseUrlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false),
                  let queryItems = responseUrlComponents.queryItems
            else { throw URLError(.badURL) }
            
            if (userGrantedAuthorization(queryItems)) {
                DispatchQueue.main.async {
                    let config = Realm.Configuration(
                        schemaVersion: 4)
                    // Use this configuration when opening realms
                    Realm.Configuration.defaultConfiguration = config
                    
                    let realm = try! Realm()
                    print(realm.configuration.fileURL!.path())
                    try! realm.write {
                        realm.add(user)
                    }
                }
                await handleGrantedAuthorization(user: user, queryItems: queryItems)
                DispatchQueue.main.async {
                    let realm = try! Realm()
                    try! realm.write {
                        user.authorizationStatus = .granted
                    }
                }
            }
            else {
                // Handle authorization denied flow
                print("Denied. User not created.")
                
            }
        } catch {
            printError("\(error)")
        }
    }
    
    /// Returns `true` if user granted authorization to the application and response included the "code" value; `false`, otherwise.
    private func userGrantedAuthorization(_ queryItems: [URLQueryItem]) -> Bool {
        return queryItems.contains(where: {$0.name == "code"})
    }
    
    private func handleGrantedAuthorization(user: User, queryItems: [URLQueryItem]) async -> Void {
        do {
            // Get authorization code
            let authorizationCode = try getAuthorizationCodeFromQueryItems(queryItems)
            
            // Get access token
            let spotifyWebAccessToken = await requestAccessTokenObject(authorizationCode: authorizationCode)
            
            // Update user object in realm
            DispatchQueue.main.async {
                let realm = try! Realm()
                try! realm.write {
                    user.authorizationCode = authorizationCode
                    user.spotifyWebAccessToken = spotifyWebAccessToken
                }
            }
        } catch {
            printError("\(error)")
        }
    }
    
    /// Parses the `queryItems` and returns the authorization code.
    private func getAuthorizationCodeFromQueryItems(_ queryItems: [URLQueryItem]) throws -> String {
        guard let code = queryItems.first(where: { $0.name == "code" })?.value else { throw AuthorizationError.cannotExtractCode }
        return code
    }
    
    /// Constructs and returns the URLComponents object to request a Spotify API access token.
    private func constructAccessTokenUrlRequest(authorizationCode: String) throws -> URLRequest {
        // Construct URL Components
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = AuthorizationConstants.host
        urlComponents.path = AuthorizationConstants.AccessToken.apiTokenPath
        
        var params = AuthorizationConstants.accessTokenRequestParams
        params["code"] = authorizationCode
        urlComponents.queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let url = urlComponents.url else { throw URLError(.badURL) }
        
        // Construct URL Request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = urlComponents.query?.data(using: .utf8)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        return request
        
    }
    
    /// Requests and returns a Spotify Web Access Ttoken object.
    private func requestAccessTokenObject(authorizationCode: String) async -> SpotifyWebAccessToken? {
        do {
            let request = try constructAccessTokenUrlRequest(authorizationCode: authorizationCode)
            let (data, _) = try await URLSession.shared.data(for: request)
            let response = try JSONDecoder().decode(SpotifyWebAccessToken.self, from: data)
            return response
        } catch {
            printError("\(error)")
            return nil
        }
        
    }
}
