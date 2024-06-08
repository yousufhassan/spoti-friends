import SwiftUI
import RealmSwift


struct RootView: View {
    @EnvironmentObject private var userViewModel: UserViewModel
    
    var body: some View {
        // Navigate to the appropriate view depending on the user's authorization status
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
        RootView().environmentObject(UserViewModel())
    }
}
