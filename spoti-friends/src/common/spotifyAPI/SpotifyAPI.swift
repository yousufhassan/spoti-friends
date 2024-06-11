import Foundation

/// Singleton class for interacting with the Spotify Web API.
class SpotifyAPI {
    static let shared: SpotifyAPI = SpotifyAPI()
    
    /// API call to the Get Current User's Profile endpoint and returns a `SpotifyProfile` object.
    ///
    /// https://developer.spotify.com/documentation/web-api/reference/get-current-users-profile
    public func getCurrentUsersProfile(accessToken: String) async throws -> SpotifyProfile {
        do {
            let endpoint = "/me"
            let request = try createRequestTo(endpoint: endpoint, accessToken: accessToken, method: RequestMethod.GET)
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if (!requestSucceeded(response as! HTTPURLResponse)) { throw SpotifyAPIError.unsuccessfulRequest }
            let spotifyProfile = try convertDataToSpotifyProfile(data)
            return spotifyProfile
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
        return request
    }
    
    /// Returns `true` if the response status code is in the 200s and `false` otherwise.
    private func requestSucceeded(_ response: HTTPURLResponse) -> Bool {
        return (200...299).contains(response.statusCode)
    }
    
}


/// Different types of request methods that the Spotify API supports.
enum RequestMethod {
    static let GET = "GET"
    static let POST = "POST"
    static let PUT = "PUT"
    static let DELETE = "DELETE"
}
