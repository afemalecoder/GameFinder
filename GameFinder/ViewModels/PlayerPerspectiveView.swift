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
        
        VStack(alignment: .leading, spacing: 4) {
            Text("Player Perspectives")
                .font(.system(size: 15).bold())
                .foregroundColor(.gray)
            ScrollView(.horizontal) {
                if currentGame.player_perspectives != nil {
                        HStack {
                            ForEach(currentGame.player_perspectives ?? [TheGame.Perspective]()) { perspective in

                            Text(perspective.name)
                                    .lineLimit(1)
                                    .padding(10)
                                    .background(Color(red: 74 / 255, green: 67 / 255, blue: 172 / 255))                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                    .font(.subheadline.bold())
                                    .foregroundColor(Color.white)
                        }
                    }
                } else {
                    Text("N/A")
                        .lineLimit(1)
                        .padding(10)
                        .background(Color(red: 74 / 255, green: 67 / 255, blue: 172 / 255))                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .font(.subheadline.bold())
                        .foregroundColor(Color.white)
                }
            }
        }
    }
}
