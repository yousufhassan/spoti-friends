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
struct ListeningActivityItem: View {
    let profileImageURL: URL
    let album: Album
    let username: String
    let track: CurrentOrMostRecentTrack
    @State var backgroundColor: UIColor = UIColor.white
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                HStack {
                    ProfileImage(imageURL: profileImageURL, width: 56, height: 56)
                    
                    ListeningActivityDetails(username: username, track: track)
                    
                    AlbumCover(album: album, width: 80, height: 80)
                        .padding(.leading, 4)
                        .onAppear {
                            Task {
                                // TODO: Uncomment and replace when implementing logic
                                // backgroundColor = try await getAccentColorForImage(album.image)
                                backgroundColor = try await getAccentColorForImage("https://i.scdn.co/image/ab67616d0000b273753639aa8d7646a69fdb5879")
                            }
                        }
                }
                .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 8))
                .frame(width: geometry.size.width * 0.9, height: 96)
                .background(Color(backgroundColor))
                .cornerRadius(12)
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            }
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
    let track: CurrentOrMostRecentTrack
    
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
                Text("I Remember Everything (feat. Kacey Musgraves)")
                    .lineLimit(1)
                Text("•")
                Text("Zach Bryan")
                    .lineLimit(1)
            }
            
            // Context details row
            HStack {
                Image(systemName: "music.note.list")
                    .padding(.trailing, -6)
                    .fontWeight(.ultraLight)
                Text("maaannnnnnnnnn")
            }
        }
        .font(.system(size: 14))
        .fontWeight(.light)
        .foregroundStyle(.black)
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
                          track: track)
}
