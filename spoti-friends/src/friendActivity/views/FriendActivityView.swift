import SwiftUI

/// The view that displays the Friend Activity page which contains the listening activity for the user's friends.
///
/// - Returns: The friend activity page view.
struct FriendActivityView: View {
    @EnvironmentObject var friendActivityViewModel: FriendActivityViewModel
    
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
                ForEach(friendActivityViewModel.friendActivites) { activity in
                    ListeningActivityItem(
                        spotifyId: activity.spotifyId,
                        album: activity.album,
                        username: activity.username,
                        track: activity.track,
                        backgroundColor: activity.backgroundColor
                    )
                    .environmentObject(friendActivityViewModel)
                    
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .onAppear {
                Task {
                    try? await friendActivityViewModel.setFriendActivity()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.PresetColour.darkgrey)
    }
}

struct FriendActivity_Previews: PreviewProvider {
    static var previews: some View {
        FriendActivityView().environmentObject(FriendActivityViewModel(user: User(), friendActivites: []))
    }
}
