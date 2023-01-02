//
//  GameModesView.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 01/12/2022.
//

import SwiftUI

struct ModesView: View {
    @State var currentgame : TheGame
    
    var body: some View {   
        VStack(alignment: .leading, spacing: 2) {
            Text("Modes: ")
                .font(.system(size: 15))
                .foregroundColor(.gray)
            ScrollView(.horizontal) {
                if currentgame.game_modes != nil {
                    HStack {
                        ForEach(currentgame.game_modes ?? [TheGame.Modes]()) { game in
                            
                            Text("\(game.name),")
                        }
                    }
                } else {
                    Text("N/A")
                }
            }
        }
    }
}
