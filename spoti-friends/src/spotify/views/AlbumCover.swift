import SwiftUI

/// The View that renders an album cover image.
///
/// - Parameters:
///   - imageURL: The URL for the album cover image.
///   - width: The album cover image width.
///   - height: The album cover image height.
///
/// - Returns: A View for the album cover image.
struct AlbumCover: View {
    let imageURL: URL
    let width, height: CGFloat
    
    var body: some View {
        
        
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
        
        
        //        Image(systemName: "square.fill")
        //            .resizable()
        //            .aspectRatio(contentMode: .fill)
        //            .frame(width: 80, height: 80)
        //            .cornerRadius(8)
        //    }
    }
}

struct AlbumCover_Previews: PreviewProvider {
    static var previews: some View {
        let imageURL = URL(string: "https://i.scdn.co/image/ab67616d0000b273753639aa8d7646a69fdb5879")!
        AlbumCover(imageURL: imageURL, width: 80, height: 80)
    }
}
