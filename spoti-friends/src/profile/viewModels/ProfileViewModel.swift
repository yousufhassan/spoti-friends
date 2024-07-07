import Foundation

class ProfileViewModel {
    var user: User
    
    init(user: User){
        self.user = user
    }
    
//    func getCurrentUsersProfileDetails() async -> ProfileDetails {
//        
//        let accessToken = self.user.spotifyWebAccessToken!.access_token
//        let profile: SpotifyProfile = await SpotifyAPI.shared.getCurrentUsersProfile(accessToken: accessToken)!
//        return ProfileDetails(profile: profile)
//    }
//    
//    func getCurrentUsersFollowerCount() async -> Int {
//        let accessToken = self.user.spotifyWebAccessToken!.access_token
//        let profile: SpotifyProfile = await SpotifyAPI.shared.getCurrentUsersProfile(accessToken: accessToken)!
//    }
}
