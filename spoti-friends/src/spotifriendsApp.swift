import SwiftUI

@main
struct spoti_friendsApp: App {
    @StateObject private var userViewModel = UserViewModel()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(userViewModel)
        }
    }
}
