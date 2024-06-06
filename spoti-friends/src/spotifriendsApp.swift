import SwiftUI

@main
struct spoti_friendsApp: App {
    let signedInUser =  User()
    
    var body: some Scene {
        WindowGroup {
            UnauthenticatedHomeView()
                .onOpenURL { (responseUrl) -> Void in
                    Task {
                        await SpotifyAuth.shared.handleResponseUrl(user: signedInUser, url: responseUrl)
                    }
                }
        }
    }
}
