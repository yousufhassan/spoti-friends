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
         let imageURL = URL(string: album.image)
        
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

#Preview {
    let album = AlbumMock.zachBryan
    AlbumCover(album: album, width: 300, height: 300)
}
