import SwiftUI

/// The View that renders a Listening Acvitiy Component.
///
/// - Parameters:
///   - spotifyId: The Spotify ID for the user whose activity this is.
///   - album: The album for the current track.
///   - displayName: The display name for the user whose listenting activity this is.
///   - track: The current or most recent track to display for the user.
///   - backgroundColor: The background color to set for this item.
///
/// - Returns: A View for the Listening Activity Card.
struct ListeningActivityCard: View, Identifiable {
    let id: String
    let spotifyId: String
    let album: Album
    let displayName: String
    let track: CurrentOrMostRecentTrack
    let backgroundColor: Color;
    @State var fontColor: Color
    @EnvironmentObject var friendActivityViewModel: FriendActivityViewModel
    
    init(spotifyId: String, album: Album, displayName: String, track: CurrentOrMostRecentTrack, backgroundColor: Color) {
        self.id = spotifyId
        self.spotifyId = spotifyId
        self.album = album
        self.displayName = displayName
        self.track = track
        self.backgroundColor = backgroundColor
        self.fontColor = Color(backgroundColor).isDarkBackground() ? Color.white : Color.black
    }
    
    var body: some View {
        VStack {
            HStack {
                ZStack {
                    ProfileImage(imageName: spotifyId, width: 56, height: 56)
                        .environmentObject(friendActivityViewModel)
                    if track.playedWithinLastFifteenMinutes {   
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 12, height: 12)
                            .offset(x: 22, y: -18)
                    }
                }
                
                ListeningActivityDetails(displayName: displayName, currentTrack: track)
                    .foregroundStyle(fontColor)
                
                AlbumCover(album: album, width: 80, height: 80)
                    .padding(.leading, 4)
            }
            .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 8))
            .frame(maxWidth: 600, maxHeight: 96)
            .frame(height: 96)
            .background(Color(backgroundColor))
            .cornerRadius(12)
            .transition(.opacity)
        }
    }
}

#Preview {
    let user = UserMock.userJimHalpert
    let profile = SpotifyProfileMock.michaelScott
    let album = AlbumMock.zachBryan
    let track = CurrentOrMostRecentTrackMock.iRememberEverything
    
    ListeningActivityCard(spotifyId: profile.spotifyId,
                          album: album,
                          displayName: profile.displayName,
                          track: track,
                          backgroundColor: Color.gray
    )
    .environmentObject(FriendActivityViewModel(user: user, friendActivites: []))
}
