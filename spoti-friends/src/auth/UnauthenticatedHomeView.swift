import SwiftUI

struct UnauthenticatedHomeView: View {
    var body: some View {
        NavigationStack {
            VStack() {
                // Title and subtitle
                HStack {
                    VStack(alignment: .leading) {
                        Text("Spoti\nfriends")
                            .font(.system(size: 60, weight: .heavy))
                            .padding(.bottom, 4)
                            .foregroundColor(Color.PresetColour.white)
                        Group {
                            Text("Listen ").foregroundColor(Color.PresetColour.white) +
                            Text("together").foregroundColor(Color.PresetColour.spotifyGreen)
                        }
                        .font(.system(size: 22, weight: .regular))
                    }
                    Spacer()  // This is here to push the title and subtitle to the left
                }
                .padding()
                .padding(.top, 30)
                
                // For the empty space in the middle of the view
                Spacer().frame(height: 320)
                
                // Sign in button
                Button {
                    // Construct and redirect the user to the authorization URL
                    // The response is handled in spotifriendsApp in the .onOpenURL() handler
                    let authorizationUrl = SpotifyAuth.shared.constructAuthorizationURL()
                    if let url = URL(string: (authorizationUrl?.url!.absoluteString)!) {
                        UIApplication.shared.open(url)
                    }
                } label: {
                    Text("Sign in with Spotify")
                        .padding()
                        .frame(width: 234)
                        .background(Color.PresetColour.spotifyGreen)
                        .foregroundColor(Color.PresetColour.white)
                        .cornerRadius(30)
                }
                
                Spacer()  // To have some empty space at the bottom
            }
            .padding()
            .background(backgroundGradient)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        UnauthenticatedHomeView()
    }
}

