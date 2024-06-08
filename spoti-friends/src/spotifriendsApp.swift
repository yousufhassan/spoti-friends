import SwiftUI

@main
struct spoti_friendsApp: App {
    @StateObject private var userViewModel = UserViewModel()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(userViewModel)
                // TODO: maybe move the handler into the UserViewModel and call that instead
                // and make the SpotifyAuth.shared.handleResponseUrl call from within that, and taking out unrelated logic
                // from there and putting it into the UserViewModel.
                .onOpenURL { (responseUrl) -> Void in
                    Task {
                        await SpotifyAuth.shared.handleResponseUrl(user: userViewModel.user, url: responseUrl)
                    }
                }
        }
    }
}
