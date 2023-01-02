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
        VStack(alignment: .leading, spacing: 4) {
            Text("Modes")
                .font(.system(size: 15).bold())
                .foregroundColor(.gray)
            ScrollView(.horizontal) {
                if currentgame.game_modes != nil {
                    HStack {
                        ForEach(currentgame.game_modes ?? [TheGame.Modes]()) { game in
                            
                            Text(game.name)
                                .lineLimit(1)
                                .padding(10)
                                .background(Color(red: 74 / 255, green: 67 / 255, blue: 172 / 255))                                .clipShape(RoundedRectangle(cornerRadius: 20))
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
