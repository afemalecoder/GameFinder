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
        
        VStack(alignment: .leading, spacing: 2) {
            Text("Player Perspectives:")
                .font(.system(size: 15))
                .foregroundColor(.gray)
            ScrollView(.horizontal) {
                if currentGame.player_perspectives != nil {
                        HStack {
                            ForEach(currentGame.player_perspectives ?? [TheGame.Perspective]()) { perspective in

                            Text(perspective.name)
                        }
                    }
                } else {
                    Text("N/A")
                }
            }
        }
    }
}
