import SwiftUI


struct RootView: View {
    /// The signed in user.
    @Environment(User.self) private var user
    
    var body: some View {
        NavigationStack {
            switch user.authorizationStatus {
            case .unauthenticated:
                SignInView()
            case .granted:
                FriendActivityView()
            case .denied:
                DeniedView()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
