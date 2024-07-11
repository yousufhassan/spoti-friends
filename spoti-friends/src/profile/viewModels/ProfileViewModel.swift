import Foundation

class ProfileViewModel: ObservableObject {
    @Published var user: User
    
    init(user: User){
        self.user = user
    }
    
    /// Fetches and returns the follower count for the logged in user.
    @MainActor func getCurrentUsersFollowerCount() async -> Int {
        do {
            let accessToken = try await self.user.getSpotifyWebAccessToken().access_token
            let response = try await SpotifyAPI.shared.fetch(endpoint: .getCurrentUsersProfile,
                                                              responseType: GetCurrentUserProfileResponse.self,
                                                              accessToken: accessToken)
            return response.followers.total
        } catch {
            printError("\(error)")
        }
        return -1
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
