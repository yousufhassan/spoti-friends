import SwiftUI

@main
struct spoti_friendsApp: App {
    var body: some Scene {
        WindowGroup {
            UnauthenticatedHomeView()
                .onOpenURL { responseUrl in print(responseUrl); SpotifyAuth.shared.handleResponseUrl(responseUrl) }
        }
    }
}
