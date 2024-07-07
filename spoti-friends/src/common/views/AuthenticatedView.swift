import SwiftUI

/// The view for when a user is signed into the app.
struct AuthenticatedView: View {
    @EnvironmentObject var friendActivityViewModel: FriendActivityViewModel
    
    init() {
        let appearance = UITabBar.appearance()
        appearance.backgroundColor = UIColor(Color.PresetColour.darkgrey)
    }
    
    var body: some View {
        TabView {
            FriendActivityView().tabItem { Label("Friend Activity", systemImage: "figure.socialdance") }
            ProfileView(profile: friendActivityViewModel.user.spotifyProfile!).tabItem { Label("My Profile", systemImage: "person") }
        }
        .environmentObject(friendActivityViewModel)
    }
}

#Preview {
    let user = UserMock.userJimHalpert
    let activites = ListeningActivityCardMock.allCards
    
    AuthenticatedView()
        .environmentObject(FriendActivityViewModel(user: user, friendActivites: activites))
}
