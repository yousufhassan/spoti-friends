import Foundation
import Combine
import SwiftUI

class FriendActivityViewModel: ObservableObject {
    @Published var user: User
    @Published var friendActivites: [ListeningActivityItem]
    private var cancellables = Set<AnyCancellable>()
    
    init(user: User, friendActivites: [ListeningActivityItem]) {
        self.user = user
        self.friendActivites = friendActivites
        
        // Set up the timer to fire every 60 seconds
        let refreshInterval: TimeInterval = 6
        Timer.publish(every: refreshInterval, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.refreshFriendActivity()
            }
            .store(in: &cancellables)
    }
    
    @MainActor public func setFriendActivity() async throws -> Void {
        do {
            var accessToken: String = ""
            accessToken = try await self.user.getInternalAPIAccessToken().accessToken
            let friends = try await SpotifyAPI.shared.getListOfUsersFriends(internalAPIAccessToken: accessToken)
            var friendActivities: [ListeningActivityItem] = []
            for friend in friends {
                let backgroundColor = Color(try await getAccentColorForImage((friend.currentOrMostRecentTrack?.track?.album!.image)!))
                let activity = ListeningActivityItem(profileImageURL: URL(string: friend.image),
                                                     album: (friend.currentOrMostRecentTrack?.track?.album)!,
                                                     username: friend.displayName,
                                                     track: friend.currentOrMostRecentTrack!,
                                                     backgroundColor: backgroundColor)
                friendActivities.append(activity)
            }
            self.friendActivites = friendActivities
        } catch {
            printError("\(error)")
            throw error
        }
    }
    
    private func refreshFriendActivity() {
        Task {
            try? await setFriendActivity()
        }
    }
}
