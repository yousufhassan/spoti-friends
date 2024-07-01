import SwiftUI

/// The view for when a user is signed into the app.
struct AuthenticatedView: View {
    @EnvironmentObject var friendActivityViewModel: FriendActivityViewModel
    
    init() {
        let appearance = UITabBar.appearance()
        // Set the background color of the TabView's tab bar
        appearance.backgroundColor = UIColor(Color.PresetColour.darkgrey)
        }
    
    var body: some View {
        TabView {
            FriendActivityView().tabItem { Label("Friend Activity", systemImage: "figure.socialdance") }
                .environmentObject(friendActivityViewModel)
            MyProfileView().tabItem { Label("Profile", systemImage: "person") }
        }
    }
}

#Preview {
    AuthenticatedView()
}
