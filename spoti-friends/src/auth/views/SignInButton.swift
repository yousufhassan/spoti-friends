import SwiftUI

struct SignInButton: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @Binding var showWebView: Bool
    @Binding var responseUrl: URL?
    let buttonLabel: String = "Sign in with Spotify"
    
    var body: some View {
        Button(buttonLabel) {
            // On button click, show the authorizationWebView
            showWebView = true
        }
        .padding()
        .frame(width: 234)
        .background(Color.PresetColour.spotifyGreen)
        .foregroundColor(Color.PresetColour.white)
        .cornerRadius(30)
        .sheet(isPresented: $showWebView) {
            NavigationStack {
                let userAuthorizationUrl = userViewModel.getUserAuthorizationUrl()
                AuthorizationWebView(
                    url: userAuthorizationUrl,
                    showWebView: $showWebView,
                    responseUrl: $responseUrl
                )
                .ignoresSafeArea()
            }
        }
        .onChange(of: responseUrl) {
            if let url = responseUrl {
                Task {
                    await SpotifyAuth.shared.handleResponseUrl(user: userViewModel.user, url: url)
                }
            }
        }
    }
}

//#Preview {
//    SignInButton()
//}
