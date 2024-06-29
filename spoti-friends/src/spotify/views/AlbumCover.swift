import SwiftUI

/// The View that renders an album cover image.
///
/// - Parameters:
///   - album: The album whose cover to display.
///   - width: The album cover image width.
///   - height: The album cover image height.
///
/// - Returns: A View for the album cover image.
struct AlbumCover: View {
    let album: Album
    let width, height: CGFloat
    
    var body: some View {
        // TODO: Uncomment and replace when removing hard-coded value
        // let imageURL = URL(string: album.image)
        let imageURL = URL(string: "https://i.scdn.co/image/ab67616d0000b273753639aa8d7646a69fdb5879")
        
        // TODO: Uncomment and replace when removing hard-coded value
        // Link (destination: URL(string: album.spotifyUri)!) {
        Link (destination: URL(string: "spotify:track:4KULAymBBJcPRpk1yO4dOG")!) {
            AsyncImage(url: imageURL) { phase in
                switch phase {
                case .empty:
                    ProgressView() // Shows a progress indicator while loading
                case .success(let image):
                    image
                        .resizable()
                case .failure:
                    Image(systemName: "person.circle.fill")
                        .resizable()
                @unknown default:
                    EmptyView()
                }
            }
            .aspectRatio(contentMode: .fill)
            .frame(width: width, height: height)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

struct AlbumCover_Previews: PreviewProvider {
    static var previews: some View {
        let album = Album()
        AlbumCover(album: album, width: 80, height: 80)
    }
}
