//
//  GameModesView.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 01/12/2022.
//

import SwiftUI

struct GameModesView: View {
    @State var currentgame : TheGame
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Modes: ")
                .font(.system(size: 12))
                .foregroundColor(.gray)
            if currentgame.game_modes != nil {
                HStack {
                    ForEach(currentgame.game_modes ?? [TheGame.Modes]()) { game in
                        Text(game.name)
                       
                    }
                }
            } else {
                Text("N/A")
            }
        }
    }
}
