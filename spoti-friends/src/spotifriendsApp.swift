import SwiftUI

@main
struct spoti_friendsApp: App {
    @State var signedInUser =  User()
    
    var body: some Scene {
        WindowGroup {
            UnauthenticatedHomeView()
                .environment(signedInUser)
                .onOpenURL { (responseUrl) -> Void in
                    Task {
                        await SpotifyAuth.shared.handleResponseUrl(user: signedInUser, url: responseUrl)
                    }
                }
        }
    }
}
