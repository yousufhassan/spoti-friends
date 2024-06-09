import SwiftUI

@main
struct spoti_friendsApp: App {
    @StateObject private var userViewModel = AuthorizationViewModel()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(userViewModel)
        }
    }
}
