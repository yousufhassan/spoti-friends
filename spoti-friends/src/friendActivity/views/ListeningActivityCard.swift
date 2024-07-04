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
                ProfileImage(imageName: spotifyId, width: 56, height: 56)
                    .environmentObject(friendActivityViewModel)
                
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

/// The View that renders the details for a listening activity item.
///
/// - Parameters:
///   - displayName: The display name for the user whose listenting activity this is.
///   - track: The current or most recent track to display for the user.
///
/// - Returns: A View for the Listening Activity Details.
struct ListeningActivityDetails: View {
    let displayName: String
    let currentTrack: CurrentOrMostRecentTrack
    @State var contextIcon: Image
    
    init(displayName: String, currentTrack: CurrentOrMostRecentTrack) {
        self.displayName = displayName
        self.currentTrack = currentTrack
        self.contextIcon = getImageForContextType()
        
        func getImageForContextType() -> Image {
            let contextType = currentTrack.track?.context?.type
            
            switch contextType {
            case .album: return Image(systemName: "smallcircle.circle")
            case .artist: return Image(systemName: "person.fill")
            case .playlist: return Image(systemName: "music.note")
            default: return Image(systemName: "music.note")
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            // Username row
            HStack {
                Text(displayName)
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
                contextIcon
                    .padding(.trailing, -6)
//                    .fontWeight()
                Text(currentTrack.track?.context?.name ?? "Error")
                    .lineLimit(1)
            }
        }
        .font(.system(size: 14))
        .fontWeight(.light)
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
