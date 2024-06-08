import Foundation
import SwiftUI
import RealmSwift

class UserViewModel: ObservableObject {
    @Published var user: User
    private var notificationToken: NotificationToken?
    
    init() {
        self.user = User()
        DispatchQueue.main.async {
            let config = Realm.Configuration(
                schemaVersion: 2)
            // Use this configuration when opening realms
            Realm.Configuration.defaultConfiguration = config
            
            let realm = try! Realm()
            try! realm.write {
                realm.add(self.user)
            }
            
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
    
    /// Handler for when the user has completed the Spotify authorization process and is redirected back to the app.
    public func handleRedirectBackToApp(_ responseUrl: URL) -> Void {
        Task {
            await SpotifyAuth.shared.handleResponseUrl(user: self.user, url: responseUrl)
        }
    }
    
    /// Stores the `sp_dc` cookie in the `user` object.
    public func storeSpDcCookie(_ cookie: HTTPCookie) -> Void {
        let spDcCookie = convertToSpDcCookie(cookie)
        self.user.setSpDcCookie(spDcCookie)
    }
    
    /// Converts the cookie from Spotify from type `HTTPCookie` to `SpDcCookie`.
    ///
    /// We only store the relevant data fields: the cookie value and the cookie expiry date.
    private func convertToSpDcCookie(_ cookie: HTTPCookie) -> SpDcCookie {
        let spDcCookie = SpDcCookie()
        spDcCookie.value = cookie.value
        spDcCookie.expiresDate = cookie.expiresDate
        return spDcCookie
    }
}
