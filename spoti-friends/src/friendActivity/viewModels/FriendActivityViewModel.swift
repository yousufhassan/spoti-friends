import Foundation

class FriendActivityViewModel: ObservableObject {
    @Published var user: User
    @Published var friendActivites: [ListeningActivityItem]
    
    init(user: User, friendActivites: [ListeningActivityItem]) {
        self.user = user
        self.friendActivites = friendActivites
    }
    
    @MainActor public func setFriendActivity() async throws -> Void {
        do {
            var accessToken: String = ""
                accessToken = try await self.user.getInternalAPIAccessToken().accessToken
            let friends = try await SpotifyAPI.shared.getListOfUsersFriends(internalAPIAccessToken: accessToken)
            var friendActivities: [ListeningActivityItem] = []
            for friend in friends {
                let activity = ListeningActivityItem(profileImageURL: URL(string: friend.image),
                                                     album: (friend.currentOrMostRecentTrack?.track?.album)!,
                                                     username: friend.displayName,
                                                     track: friend.currentOrMostRecentTrack!)
                friendActivities.append(activity)
            }
            self.friendActivites = friendActivities
        } catch {
            printError("\(error)")
            throw error
        }
    }
}
