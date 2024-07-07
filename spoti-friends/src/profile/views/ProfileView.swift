import SwiftUI

/// Renders the View for a user's profile.
struct ProfileView: View {
    let profile: SpotifyProfile
//    @EnvironmentObject var friendActivityViewModel: FriendActivityViewModel
    
    init(profile: SpotifyProfile) {
        self.profile = profile
    }
    
    var body: some View {
//        ScrollView {
            VStack {
                ProfileDetails(profile: profile)
//                    .environmentObject(friendActivityViewModel)
                
                Spacer()
                
                LogoutButton()
                    .padding(.bottom, 10)
            }
//        }
            .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.PresetColour.darkgrey)
    }
}

/// The view for the log out button.
struct LogoutButton: View {
    @EnvironmentObject private var authorizationViewModel: AuthorizationViewModel
    
    var body: some View {
        let buttonLabel = "Log out"
        Button(action: {
            authorizationViewModel.signOutUser()
        }) {
            Text(buttonLabel)
                .frame(width: 320, height: 50) // Adjust the height as needed
                .background(Color.PresetColour.transparentMaroon)
                .foregroundColor(Color.PresetColour.red)
                .fontWeight(.semibold)
                .cornerRadius(12)
        }
    }
}

#Preview {
    let user = UserMock.userJimHalpert
    ProfileView(profile: user.spotifyProfile!)
        .environmentObject(FriendActivityViewModel(user: user, friendActivites: []))
}
