import Foundation
import SwiftUI
import RealmSwift

class UserViewModel: ObservableObject {
    @Published var user: User
    private var notificationToken: NotificationToken?
    
    init() {
        self.user = User()
        DispatchQueue.main.async {
            let realm = try! Realm()
            try! realm.write {
                realm.add(self.user)
            }
            print("Created user in VM!")
            
            self.notificationToken = realm.observe { [weak self] _, _ in
                self?.objectWillChange.send()
            }
        }
        //        let realm = try! Realm()
        //        if let existingUser = realm.objects(User.self).first {
        //            self.user = existingUser
        //            print("LOG: Found existing user")
        //        } else {
        //            self.user = User()
        //            try! realm.write {
        //                realm.add(self.user)
        //            }
        //            print("LOG: Created new user")
        //        }
    }
    
    /// Returns the Spotify user authorization URL
    public func getUserAuthorizationUrl() -> URL {
        return SpotifyAuth.shared.constructAuthorizationUrl()!
    }
}
