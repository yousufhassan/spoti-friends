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
                schemaVersion: 4)
            // Use this configuration when opening realms
            Realm.Configuration.defaultConfiguration = config
            
            let realm = try! Realm()
            
            // If we find a matching user in the database, set that as current user.
            // Otherwise, this is a new user.
            if let existingUser = realm.objects(User.self).first {
                self.user = existingUser
            } else {
                self.user = User()
            }
            
            self.notificationToken = realm.observe { [weak self] _, _ in
                self?.objectWillChange.send()
            }
        }
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
    
    /// Handler for when the `sp_dc` cookie is fetched.
    public func handleFetchedSpDcCookie(_ cookie: HTTPCookie?) -> Void {
        let spDcCookie = convertToSpDcCookie(cookie)
        self.user.spDcCookie = spDcCookie
    }
    
    /// Stores the `sp_dc` cookie in the `user` object.
    public func storeSpDcCookie(_ cookie: HTTPCookie) -> Void {
        let spDcCookie = convertToSpDcCookie(cookie)
        self.user.setSpDcCookie(spDcCookie)
    }
    
    /// Converts the cookie from Spotify from type `HTTPCookie` to `SpDcCookie`.
    ///
    /// We only store the relevant data fields: the cookie value and the cookie expiry date.
    private func convertToSpDcCookie(_ cookie: HTTPCookie?) -> SpDcCookie {
        let spDcCookie = SpDcCookie()
        spDcCookie.value = cookie?.value ?? ""
        spDcCookie.expiresDate = cookie?.expiresDate
        return spDcCookie
    }
}