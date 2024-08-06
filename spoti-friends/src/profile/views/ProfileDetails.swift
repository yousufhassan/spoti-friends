import SwiftUI


/// Renders the View for a user's Spotify Profile details.
/// In other words: their profile image, display name, follower count, and playlist count.
///
/// - Parameters:
///   - profile: The `SpotifyProfile` to display the details for.
struct ProfileDetails: View {
    let profile: SpotifyProfile
    @State private var followerCount: Int = -1
    @State private var playlistCount: Int = -1
    @EnvironmentObject var profileViewModel: ProfileViewModel
    @EnvironmentObject var friendActivityViewModel: FriendActivityViewModel
    
    init(profile: SpotifyProfile) {
        self.profile = profile
    }
    
    var body: some View {
        HStack(spacing: 12) {
            ProfileImage(imageName: profile.image, width: 80, height: 80)
                .environmentObject(friendActivityViewModel)

            VStack(alignment: .leading, spacing: 8) {
                Text(profile.displayName)
                    .foregroundStyle(Color.PresetColour.whitePrimary)
                HStack {
                    Text("\(followerCount) followers")
                    Text("•")
                    Text("\(playlistCount) playlists")
                }
                .foregroundStyle(Color.PresetColour.whiteSecondary)
                .onAppear {
                    Task {
                        // NOTE: Comment out these lines to fix SwiftUI Previews
                        followerCount = await profileViewModel.getCurrentUsersFollowerCount()
                        playlistCount = await profileViewModel.getCurrentUsersPlaylistCount()
                    }
                }
            }
            Spacer()
        }
    }
}

#Preview {
    let user = UserMock.userJimHalpert
    ProfileDetails(profile: user.spotifyProfile!)
        .environmentObject(ProfileViewModel(user: user))
        .environmentObject(FriendActivityViewModel(user: user, friendActivites: []))
}
