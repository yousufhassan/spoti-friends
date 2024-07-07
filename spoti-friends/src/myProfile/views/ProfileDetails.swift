import SwiftUI


/// Renders the View for a user's Spotify Profile details.
/// In other words: their profile image, display name, follower count, and playlist count.
///
/// - Parameters:
///   - profile: The `SpotifyProfile` to display the details for.
struct ProfileDetails: View {
    let profile: SpotifyProfile
    
    var body: some View {
        HStack(spacing: 12) {
            ProfileImage(imageName: profile.image, width: 80, height: 80)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(profile.displayName)
                    .foregroundStyle(Color.PresetColour.whitePrimary)
                HStack {
                    Text("4 followers")
                    Text("•")
                    Text("21 playlists")
                }
                .foregroundStyle(Color.PresetColour.whiteSecondary)
            }
            Spacer()
        }
    }
}

#Preview {
    let user = UserMock.userJimHalpert
    ProfileDetails(profile: user.spotifyProfile!)
        .environmentObject(FriendActivityViewModel(user: user, friendActivites: []))
}
