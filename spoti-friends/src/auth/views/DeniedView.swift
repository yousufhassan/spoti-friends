import SwiftUI

/// The view that is rendered when the Spotify authorization for the user failed or they denied.
struct DeniedView: View {
    var body: some View {
        Text("Authorization Denied")
            .font(.largeTitle)
            .foregroundColor(.red)
            .padding()
    }
}

#Preview {
    DeniedView()
}
