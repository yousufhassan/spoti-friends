import SwiftUI

/// The view that displays the Friend Activity page which contains the listening activity for the user's friends.
///
/// - Returns: The friend activity page view.
struct FriendActivityView: View {
    @EnvironmentObject var friendActivityViewModel: FriendActivityViewModel
    
    var body: some View {
        VStack {
            // Friend Activity Header
            PageTitle(pageTitle: "Friend Activity")
            
            // List of friend's listening activities
            ScrollView {
                VStack(alignment: .center) {
                    ForEach(friendActivityViewModel.friendActivites) { activity in
                        activity
                            .environmentObject(friendActivityViewModel)
                        
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
        }
        .refreshable {
            try? await friendActivityViewModel.setFriendActivity()
        }
        .onAppear {
            Task {
                try? await friendActivityViewModel.setFriendActivity()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.PresetColour.darkgrey)
    }
}

#Preview {
    let user = UserMock.userJimHalpert
    let activities = ListeningActivityCardMock.allCards
    
    FriendActivityView()
        .environmentObject(FriendActivityViewModel(user: user, friendActivites: activities))
}
