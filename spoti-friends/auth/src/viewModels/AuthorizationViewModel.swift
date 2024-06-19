import Foundation
import SwiftUI
import RealmSwift

/// The viewmodel used for the views involving the authorization code flow.
class AuthorizationViewModel: ObservableObject {
    @Published var user: User
    @Published var authorizationStatus: AuthorizationStatus
    private var notificationToken: NotificationToken?
    
    init() {
        let realm = RealmDatabase.shared.getRealmInstance()
        
        // If we find a matching user in the database, set that as current user.
        // Otherwise, this is a new user.
        let signedInUser = getStringFromUserDefaultsValueForKey("signedInUser")
        if signedInUser != "" {
            let existingUser: User = realm.objects(User.self).where { $0.spotifyId == signedInUser }.first!
            self.user = existingUser
            self.authorizationStatus = existingUser.authorizationStatus
        } else {
            self.user = User()
            self.authorizationStatus = .unauthenticated
        }
        
        self.notificationToken = realm.observe { [weak self] _, _ in
            self?.objectWillChange.send()
        }
    }
    
    
    /// Signs out the currently signed in user.
    public func signOutUser() -> Void {
        self.user = User()
        self.authorizationStatus = .unauthenticated
        storeInUserDefaults(key: "signedInUser", value: "")
    }
    
    /// Returns the Spotify user authorization URL.
    public func getUserAuthorizationUrl() -> URL {
        return SpotifyAuth.shared.constructAuthorizationUrl()!
    }
    
    /// Handler for when the user has completed the Spotify authorization process and is redirected back to the app.
    public func handleRedirectBackToApp(_ responseUrl: URL) -> Void {
        Task {
            await SpotifyAuth.shared.handleResponseUrl(user: self.user, url: responseUrl, authorizationStatus: &self.authorizationStatus)
        }
    }
    
    /// Handler for when the `sp_dc` cookie is fetched. It stores the cookie value in the user object, but does not save to database.
    public func handleFetchedSpDcCookie(_ cookie: HTTPCookie?) -> Void {
        let spDcCookie = convertToSpDcCookie(cookie)
        self.user.spDcCookie = spDcCookie
    }
    
    /// Converts the cookie from Spotify from type `HTTPCookie` to `SpDcCookie`.'
    private func convertToSpDcCookie(_ cookie: HTTPCookie?) -> SpDcCookie {
        let spDcCookie = SpDcCookie()
        spDcCookie.value = cookie?.value ?? ""
        spDcCookie.expiresDate = cookie?.expiresDate
        return spDcCookie
    }
}
