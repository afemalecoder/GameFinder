//
//  MultiplayerView.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 13/12/2022.
//

import SwiftUI

struct MultiplayerView: View {
    @State var currentGame : TheGame
    
    var body: some View {
        
        ForEach(currentGame.multiplayer_modes ?? [TheGame.Multiplayer]()) { game in
            Text("Campaign coop: \(game.campaigncoop ? "YES" : "NO")")
            Text("Lan coop: \(game.lancoop ? "YES" : "NO")")
            Text("Offline coop: \(game.offlinecoop ? "YES" : "NO")")
            if game.offlinecoop {
                Text("Amount players: \(game.offlinecoopmax ?? 0)")
            }
            Text("Online coop: \(game.onlinecoop ? "YES" : "NO")")
            if game.onlinecoop {
                Text("Amount players: \(game.onlinecoopmax ?? 0)")
            }
            Text("Splitscreen: \(game.splitscreen ? "YES" : "NO")")
        }
    }
}
