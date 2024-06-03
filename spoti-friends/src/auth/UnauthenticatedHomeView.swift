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
                    Task {
                        let authorizationUrl = SpotifyAuth.shared.getAuthorizationURL()
                        if let url = URL(string: (authorizationUrl?.url!.absoluteString)!) {
                            await UIApplication.shared.open(url)
                            let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
                            let queryItems = components?.queryItems
                            let code = queryItems?.first(where: { $0.name == "code" })?.value
                            print("Code: \(code ?? "No code found")")
                            print(url)
                            
                        }
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
