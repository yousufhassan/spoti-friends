import SwiftUI


/// Renders the View for a user's Spotify Profile details.
/// In other words: their profile image, display name, follower count, and playlist count.
///
/// - Parameters:
///   - profile: The `SpotifyProfile` to display the details for.
struct ProfileDetails: View {
    let profile: SpotifyProfile
    @State private var followerCount: Int = 0
    @State private var playlistCount: Int = 0
    @State private var profileViewModel: ProfileViewModel
    @EnvironmentObject var authorizationViewModel: AuthorizationViewModel
    
    init(profile: SpotifyProfile) {
        self.profile = profile
        self.profileViewModel = ProfileViewModel(user: User())
//        self.playlistCount = 0
    }
    
    var body: some View {
        HStack(spacing: 12) {
            ProfileImage(imageName: profile.image, width: 80, height: 80)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(profile.displayName)
                    .foregroundStyle(Color.PresetColour.whitePrimary)
                HStack {
                    Text("\(followerCount) followers")
                    Text("•")
                    Text("21 playlists")
                }
                .foregroundStyle(Color.PresetColour.whiteSecondary)
                .onAppear {
                    Task {
                        followerCount = await profileViewModel.getCurrentUsersFollowerCount()
                    }
                }
            }
            Spacer()
        }
        .onAppear {
            self.profileViewModel.user = authorizationViewModel.user
        }
    }
}

#Preview {
    let user = UserMock.userJimHalpert
    ProfileDetails(profile: user.spotifyProfile!)
        .environmentObject(FriendActivityViewModel(user: user, friendActivites: []))
}
