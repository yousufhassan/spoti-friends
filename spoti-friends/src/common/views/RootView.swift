import SwiftUI
import RealmSwift

/// The view that is rendered when the app opens, depending on the user's authorization status.
///
/// If the user granted authorization, render the `FriendActivityView`.
///
/// If the user denied authorization, render the `DeniedView`.
///
/// If the user has not completed authorization, render the `SignInView`.
struct RootView: View {
    @EnvironmentObject private var authorizationViewModel: AuthorizationViewModel
    
    var body: some View {
        // Navigate to the appropriate view depending on the user's authorization status
        NavigationStack {
            switch authorizationViewModel.user.authorizationStatus {
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
        RootView().environmentObject(AuthorizationViewModel())
    }
}
