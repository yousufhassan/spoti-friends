import SwiftUI

/// The view that displays the Friend Activity page which contains the listening activity for the user's friends.
///
/// - Returns: The friend activity page view.
struct FriendActivityView: View {
    var body: some View {
        VStack {
            // Friend Activity Header
            HStack {
                PageTitle(pageTitle: "Friend Activity")
                RotatingSyncIcon(width: 36, color: Color.PresetColour.white)
            }
            .padding(.trailing, 24)
            
            // List of friend's listening activities
            VStack(alignment: .center) {
                let profileImageURL = URL(string: "https://i.scdn.co/image/ab6775700000ee8593e8cec90c9689ba0f18c26f")!
                let album = Album()
                let username = "yousuf"
                let track = CurrentOrMostRecentTrack()  // dummy object just to please Preview Simulator
                
                ListeningActivityItem(
                    profileImageURL: profileImageURL,
                    album: album,
                    username: username,
                    track: track)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.PresetColour.darkgrey)
    }
}

struct FriendActivity_Previews: PreviewProvider {
    static var previews: some View {
        FriendActivityView()
    }
}
