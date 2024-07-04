import SwiftUI

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
                TrackTimestampView(timestamp: currentTrack.timestamp)
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
                Text(currentTrack.track?.context?.name ?? "Error")
                    .lineLimit(1)
            }
        }
        .font(.system(size: 14))
        .fontWeight(.light)
    }
}

/// The View that renders the time elapsed since a track was played or a playing now icon.
///
/// - Parameters:
///   - timestamp: The `TimeInterval` for when the track was played.
///
/// - Returns: A View rendering a playing now icon or a string displaying when the track was played relative to now.
struct TrackTimestampView: View {
    let timestamp: TimeInterval
    
    var body: some View {
        if hasFifteenMinutesPassed(since: timestamp) {
            let relativeTimeElapsed = getRelativeTime(since: timestamp)
            Text(relativeTimeElapsed)
        } else {
            Image(.nowPlaying)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 16, height: 16)
        }
    }
}

#Preview {
    let details = ListeningActivityCardMock.dwightSchruteActivity
    ListeningActivityDetails(displayName: details.displayName, currentTrack: details.track)
}
