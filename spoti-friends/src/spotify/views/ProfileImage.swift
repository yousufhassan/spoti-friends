import SwiftUI

/// The View that renders a profile image.
///
/// - Parameters:
///   - imageURL: The URL for the profile image.
///   - width: The profile image width.
///   - height: The profile image height.
///
/// - Returns: A View for the profile image.
struct ProfileImage: View {
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
        .clipShape(Circle())
    }
}

#Preview {
    let profileImageURL = URL(string: "https://i.scdn.co/image/ab6775700000ee8593e8cec90c9689ba0f18c26f")!
    ProfileImage(imageURL: profileImageURL, width: 80, height: 80)
}
