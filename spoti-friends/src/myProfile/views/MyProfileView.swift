import SwiftUI

/// Renders the View for a user's profile.
struct MyProfileView: View {
    var body: some View {
        VStack {
            let pageTitle = "My Profile"
            PageTitle(pageTitle: pageTitle)
            
            // The page content will go below when implemented.
            
            Spacer()
            
            LogoutButton()
                .padding(.bottom, 10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.PresetColour.darkgrey)
    }
}

struct LogoutButton: View {
    @EnvironmentObject private var authorizationViewModel: AuthorizationViewModel
    
    var body: some View {
        let buttonLabel = "Log out"
        Button(action: {
            authorizationViewModel.signOutUser()
        }) {
            Text(buttonLabel)
                .frame(width: 320, height: 50) // Adjust the height as needed
                .background(Color.PresetColour.transparentMaroon)
                .foregroundColor(Color.PresetColour.red)
                .fontWeight(.semibold)
                .cornerRadius(12)
        }
    }
}

#Preview {
    MyProfileView()
}
