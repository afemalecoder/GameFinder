//
//  PlayerPerspectiveView.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 13/12/2022.
//

import SwiftUI

struct PlayerPerspectiveView: View {
    @State var currentGame : TheGame
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Player Perspectives:")
                .font(.system(size: 12))
                .foregroundColor(.gray)
            if currentGame.player_perspectives != nil {
                
                ForEach(currentGame.player_perspectives ?? [TheGame.Perspective]()) { perspective in
                    HStack {
                        Text(perspective.name)
                    }
                }
            } else {
                Text("N/A")
            }
        }
    }
}
