import SwiftUI

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
