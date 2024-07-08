import Foundation

class ProfileViewModel {
    var user: User
    
    init(user: User){
        self.user = user
    }
    
    /// Fetches and returns the follower count for the logged in user.
    @MainActor func getCurrentUsersFollowerCount() async -> Int {
        let accessToken = self.user.spotifyWebAccessToken!.access_token
        do {
            let response = try await SpotifyAPI.shared.fetch(endpoint: .getCurrentUsersProfile,
                                                              responseType: GetCurrentUserProfileResponse.self,
                                                              accessToken: accessToken)
            return response.followers.total
        } catch {
            printError("\(error)")
        }
        return 0
    }
}

/// Contains the structs relevant to the ProfileViewModel
extension ProfileViewModel {
    private struct GetCurrentUserProfileResponse: Decodable {
        let followers: Followers
        
        struct Followers: Decodable {
            let total: Int
        }
    }
}
