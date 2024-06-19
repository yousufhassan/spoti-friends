import SwiftUI

/// The view for when a user is signed into the app.
struct AuthenticatedView: View {
    init() {
        let appearance = UITabBar.appearance()
        // Set the background color of the TabView's tab bar
        appearance.backgroundColor = UIColor(Color.PresetColour.navbar)
        }
    
    var body: some View {
        TabView {
            FriendActivityView().tabItem { Label("Friend Activity", systemImage: "person.2") }
            MyProfileView().tabItem { Label("Profile", systemImage: "person") }
        }
    }
}

#Preview {
    AuthenticatedView()
}
