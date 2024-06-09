import Foundation

/// Singleton class for interacting with the Spotify Web API.
class SpotifyAPI {
    static let shared: SpotifyAPI = SpotifyAPI()
    
    /// API call to the Get Current User's Profile endpoint.
    ///
    /// https://developer.spotify.com/documentation/web-api/reference/get-current-users-profile
    public func getCurrentUsersProfile(accessToken: String) async throws -> Any {
        do {
            let endpoint = "/me"
            let request = try createRequestTo(endpoint: endpoint, accessToken: accessToken, method: RequestMethod.GET)
            let (_, response) = try await URLSession.shared.data(for: request)
            return response
        } catch {
            printError("\(error)")
            throw error
        }
    }
}


extension SpotifyAPI {
    /// Creates and returns the URLRequest object to corresponding Spotify API `endpoint`
    ///
    /// `endpoint` should be prepended with a "/".
    private func createRequestTo(endpoint: String, accessToken: String, method: String) throws -> URLRequest {
        guard let url = URL(string: APIConstants.host + endpoint) else { throw URLError(.badURL)}
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        return URLRequest(url: url)
    }
    
    
}


/// Different types of request methods that the Spotify API supports.
enum RequestMethod {
    static let GET = "GET"
    static let POST = "POST"
    static let PUT = "PUT"
    static let DELETE = "DELETE"
}
