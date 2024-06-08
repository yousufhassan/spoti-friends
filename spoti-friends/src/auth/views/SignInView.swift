import SwiftUI

struct SignInView: View {
    @EnvironmentObject private var userViewModel: UserViewModel
    @State private var showWebView = false
    @State private var responseUrl: URL?
    
    var body: some View {
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
            Button("Sign in with Spotify") {
                showWebView = true
                
            }
            .padding()
            .frame(width: 234)
            .background(Color.PresetColour.spotifyGreen)
            .foregroundColor(Color.PresetColour.white)
            .cornerRadius(30)
            .sheet(isPresented: $showWebView) {
                NavigationStack {
                    // 3
                    let userAuthorizationUrl = userViewModel.getUserAuthorizationUrl()
                    AuthorizationWebView(url: userAuthorizationUrl, showWebView: $showWebView, responseUrl: $responseUrl)
                        .ignoresSafeArea()
                        .navigationTitle("Authorization")
                        .foregroundColor(Color.PresetColour.white)
                        .navigationBarTitleDisplayMode(.inline)
                }
            }
            .onChange(of: responseUrl) { newValue in
                        if let url = newValue {
                            Task {
                                await SpotifyAuth.shared.handleResponseUrl(user: userViewModel.user, url: url)
                            }
                        }
                    }
            //            Button {
            //                // The response is handled in spotifriendsApp in the .onOpenURL() handler
            //                userViewModel.requestUserAuthorization()
            //            } label: {
            //                Text("Sign in with Spotify")
            //                    .padding()
            //                    .frame(width: 234)
            //                    .background(Color.PresetColour.spotifyGreen)
            //                    .foregroundColor(Color.PresetColour.white)
            //                    .cornerRadius(30)
            //            }
            
            Spacer()  // To have some empty space at the bottom
        }
        .padding()
        .background(backgroundGradient)
    }
}

#Preview {
    SignInView()
}
