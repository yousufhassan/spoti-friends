import SwiftUI

struct MyProfileView: View {
    var body: some View {
        VStack {
            let pageTitle = "My Profile"
            PageTitle(pageTitle: pageTitle)
            
            // The page content will go below when implemented.
            
            Spacer()
            
            LogoutButton()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.PresetColour.darkgrey)
    }
}

struct LogoutButton: View {
    var body: some View {
        let buttonLabel = "Log out"
        Button(buttonLabel) {
            
        }
        .padding()
        .frame(width: 320)
        .background(Color.PresetColour.transparentMaroon)
        .foregroundColor(Color.PresetColour.red)
        .fontWeight(.semibold)
        .cornerRadius(12)
    }
}

#Preview {
    MyProfileView()
}
