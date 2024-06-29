import SwiftUI

struct FriendActivityView: View {
    var body: some View {
        let profileImageURL = URL(string: "https://i.scdn.co/image/ab6775700000ee8593e8cec90c9689ba0f18c26f")!
        let albumImageURL = URL(string: "https://i.scdn.co/image/ab67616d0000b273753639aa8d7646a69fdb5879")!
        let username = "yousuf"
        let track = CurrentOrMostRecentTrack()  // dummy object just to please Preview Simulator
        
        ListeningActivityItem(backgroundColor: Color.brown,
                              profileImageURL: profileImageURL,
                              albumImageURL: albumImageURL,
                              username: username,
                              track: track)
    }
}

struct FriendActivity_Previews: PreviewProvider {
    static var previews: some View {
        FriendActivityView()
    }
}
