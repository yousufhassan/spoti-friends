import Foundation
import SwiftUI
import RealmSwift

class UserViewModel: ObservableObject {
    @Published var user: User
    
    init() {
        self.user = User()
        print("Created user in VM!")
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
    
    /// Redirects user to Spotify for authorization.
    public func requestUserAuthorization() -> Void {
        if let authorizationUrl = SpotifyAuth.shared.constructAuthorizationUrl() {
            UIApplication.shared.open(authorizationUrl)
        }
    }
}
