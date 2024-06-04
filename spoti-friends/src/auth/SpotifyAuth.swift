import Foundation
import CryptoKit

/// Class that handles the Spotify Authorization Singleton.
class SpotifyAuth {
    /// Shared instance of the SpotifyAuth Singleton class.
    static let shared = SpotifyAuth()
    
    /// Constructs the authorization URL that is used to get user authorization.
    func constructAuthorizationUrl() -> URLRequest? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = AuthConstants.host
        components.path = AuthConstants.authorizePath
        
        var params = AuthConstants.authorizationRequestParams
        let codeChallenge = CodeChallenge.shared.generateCodeChallenge()
        params["code_challenge"] = codeChallenge
        components.queryItems = params.map({URLQueryItem(name: $0.key, value: $0.value)})
        
        guard let url = components.url else { return nil }
        
        // TODO: Investigate if I need to cast to a `URLRequest` since it seems to be casted back into URL when it is called in the view.
        return URLRequest(url: url)
    }
    
    /// TODO
    func handleResponseUrl(user: User, url: URL) -> Void {
        do {
            guard let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false),
                  let queryItems = urlComponents.queryItems
            else { throw URLError(.badURL) }
            
            if (userGrantedAuthorization(queryItems)) {
                // Handle authorization granted flow
                
                // Get authorization code
                let authorizationCode = try getAuthorizationCodeFromQueryItems(queryItems)
                user.authorizationCode = authorizationCode
                
                // Get access token
                let _ = requestAccessToken(authorizationCode: authorizationCode)
                
                
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
    
    /// Parses the `queryItems` and returns the authorization code.
    private func getAuthorizationCodeFromQueryItems(_ queryItems: [URLQueryItem]) throws -> String {
        guard let code = queryItems.first(where: { $0.name == "code" })?.value else { throw AuthorizationError.cannotExtractCode }
        print(code)
        return code
    }
    
    /// Constructs and returns the URLComponents object to request a Spotify API access token.
    private func constructAccessTokenUrlRequest(authorizationCode: String) throws -> URLRequest {
        // Construct URL Components
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = AuthConstants.host
        urlComponents.path = AuthConstants.apiTokenPath
        
        var params = AuthConstants.accessTokenRequestParams
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
    
    /// Requests and returns a Spotify API access token.
    private func requestAccessToken(authorizationCode: String) -> String? {
        do {
            // Make request
            let request = try constructAccessTokenUrlRequest(authorizationCode: authorizationCode)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                // Handle response
                if let error = error {
                    printError("\(error)")
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    printError("Invalid HTTP Response from requestAccessToken request")
                    return
                }
                
                guard let data = data else {
                    printError("No data received from requestAccessToken request")
                    return
                }
                
                do {
                    let jsonResponse = try JSONDecoder().decode(AccessTokenResponse.self, from: data)
                    
                    print("Response: \(jsonResponse.access_token)")
                    return
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
            
            task.resume()
            return ""
            
        } catch {
            printError("\(error)")
            return ""
        }
        
    }
}
