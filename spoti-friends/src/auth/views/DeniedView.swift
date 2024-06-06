import SwiftUI

// TODO: update this to be the actual denied view
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
