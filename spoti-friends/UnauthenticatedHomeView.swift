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
                    Spacer()
                }
                .padding()
                .padding(.top, 30)
                
                Spacer()
                    .frame(height: 320)
                
                // Sign in button
                Button (action: {}) {
                    Text("Sign in with Spotify")
                        .padding()
                        .frame(width: 234)
                        .background(Color.PresetColour.spotifyGreen)
                        .foregroundColor(Color.PresetColour.white)
                        .cornerRadius(30)
                }
                
                Spacer()
            }
            .padding()
            .background(
                LinearGradient(gradient: Color.PresetGradient.mainDarkGradient,
                               startPoint: .top,
                               endPoint: .bottom)
            )
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        UnauthenticatedHomeView()
    }
}
