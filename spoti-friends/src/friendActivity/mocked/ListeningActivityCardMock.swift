import Foundation
import SwiftUI

/// Struct containing mock Listening Activity Card objects.
struct ListeningActivityCardMock {
    static let allCards = [michaelScottActivity, dwightSchruteActivity, stanleyHudsonActivity]
    
    static let michaelScottActivity = createMockListeningActivityCard(album: AlbumMock.zachBryan,
                                                                      displayName: SpotifyProfileMock.michaelScott.displayName,
                                                                      track: CurrentOrMostRecentTrackMock.iRememberEverything,
                                                                      backgroundColor: Color.gray)
    
    static let dwightSchruteActivity = createMockListeningActivityCard(album: AlbumMock.sour,
                                                                       displayName: SpotifyProfileMock.dwightSchrute.displayName,
                                                                       track: CurrentOrMostRecentTrackMock.traitor,
                                                                       backgroundColor: Color.pink)
    
    static let stanleyHudsonActivity = createMockListeningActivityCard(album: AlbumMock.theDefinition,
                                                                       displayName: SpotifyProfileMock.stanleyHudson.displayName,
                                                                       track: CurrentOrMostRecentTrackMock.luxury,
                                                                       backgroundColor: Color.yellow)
    
    static func createMockListeningActivityCard(spotifyId: String = UUID().uuidString,
                                                 album: Album,
                                                 displayName: String,
                                                 track: CurrentOrMostRecentTrack,
                                                 backgroundColor: Color) -> ListeningActivityCard {
        return ListeningActivityCard(spotifyId: spotifyId,
                                     album: album,
                                     displayName: displayName,
                                     track: track,
                                     backgroundColor: backgroundColor)
    }
}
