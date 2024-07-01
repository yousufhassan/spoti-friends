import SwiftUI

/// The View that renders a Listening Acvitiy Component.
///
/// - Parameters:
///   - profileImageURL: The URL for the profile image.
///   - album: The album for the current track.
///   - username: The username for the user whose listenting activity this is.
///   - track: The current or most recent track to display for the user.
///
/// - Returns: A View for the Listening Activity Item.
struct ListeningActivityItem: View, Identifiable {
    let id = UUID()
    let profileImageURL: URL?
    let album: Album
    let username: String
    let track: CurrentOrMostRecentTrack
    let backgroundColor: Color;
//    @State var backgroundColor: Color = Color.gray.opacity(0.2)
    @State var fontColor: Color = Color.black
    
    var body: some View {
        VStack {
            HStack {
                ProfileImage(imageURL: profileImageURL, width: 56, height: 56)
                
                ListeningActivityDetails(username: username, currentTrack: track)
                    .foregroundStyle(fontColor)
                
                AlbumCover(album: album, width: 80, height: 80)
                    .padding(.leading, 4)
                    .onAppear {
                        Task {
//                            backgroundColor = Color(try await getAccentColorForImage(album.image))
                            fontColor = Color(backgroundColor).isDarkBackground() ? Color.white : Color.black
                        }
                    }
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
    let profileImageURL = URL(string: "https://i.scdn.co/image/ab6775700000ee8593e8cec90c9689ba0f18c26f")!
    let album = Album()
    let username = "yousuf"
    let track = CurrentOrMostRecentTrack()  // dummy object just to please Preview Simulator
    
    ListeningActivityItem(profileImageURL: profileImageURL,
                          album: album,
                          username: username,
                          track: track,
                          backgroundColor: Color.gray
    )
}
