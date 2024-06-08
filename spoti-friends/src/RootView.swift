import SwiftUI


struct RootView: View {
    @EnvironmentObject private var userViewModel: UserViewModel
    
    var body: some View {
        NavigationStack {
            switch userViewModel.user.authorizationStatus {
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
