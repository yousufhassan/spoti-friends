import SwiftUI

/// The View that renders a Listening Acvitiy Component.
///
/// - Parameters:
///   - spotifyId: The Spotify ID for the user whose activity this is.
///   - album: The album for the current track.
///   - username: The username for the user whose listenting activity this is.
///   - track: The current or most recent track to display for the user.
///   - backgroundColor: The background color to set for this item.
///
/// - Returns: A View for the Listening Activity Item.
struct ListeningActivityItem: View, Identifiable {
    let id: String
    let spotifyId: String
    let album: Album
    let username: String
    let track: CurrentOrMostRecentTrack
    let backgroundColor: Color;
    @State var fontColor: Color
    @EnvironmentObject var friendActivityViewModel: FriendActivityViewModel
    
    init(spotifyId: String, album: Album, username: String, track: CurrentOrMostRecentTrack, backgroundColor: Color) {
        self.id = spotifyId
        self.spotifyId = spotifyId
        self.album = album
        self.username = username
        self.track = track
        self.backgroundColor = backgroundColor
        self.fontColor = Color(backgroundColor).isDarkBackground() ? Color.white : Color.black
    }
    
    var body: some View {
        VStack {
            HStack {
                ProfileImage(imageName: spotifyId, width: 56, height: 56)
                    .environmentObject(friendActivityViewModel)
                
                ListeningActivityDetails(username: username, currentTrack: track)
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

/// The View that renders the details for a listening activity item.
///
/// - Parameters:
///   - username: The username for the user whose listenting activity this is.
///   - track: The current or most recent track to display for the user.
///
/// - Returns: A View for the Listening Activity Details.
struct ListeningActivityDetails: View {
    let username: String
    let currentTrack: CurrentOrMostRecentTrack
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            // Username row
            HStack {
                Text(username)
                    .fontWeight(.medium)
                Spacer()
                Image(.nowPlaying)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16, height: 16)
            }
            
            // Song details row
            HStack {
                Text(currentTrack.track?.name ?? "Error")
                    .lineLimit(1)
                Text("•")
                Text(currentTrack.track?.artist?.name ?? "Error")
                    .lineLimit(1)
            }
            
            // Context details row
            HStack {
                Image(systemName: "music.note.list")
                    .padding(.trailing, -6)
                    .fontWeight(.ultraLight)
                Text(currentTrack.track?.context?.name ?? "Error")
            }
        }
        .font(.system(size: 14))
        .fontWeight(.light)
    }
}


#Preview {
    let album = Album()
    let username = "yousuf"
    let track = CurrentOrMostRecentTrack()  // dummy object just to please Preview Simulator
    
    ListeningActivityItem(spotifyId: "",
                          album: album,
                          username: username,
                          track: track,
                          backgroundColor: Color.gray
    )
}
