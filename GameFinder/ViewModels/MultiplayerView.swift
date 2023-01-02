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
        if currentGame.multiplayer_modes != nil {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(currentGame.multiplayer_modes ?? [TheGame.Multiplayer]()) { game in
                        Group {
                            VStack {
                                Text("Campaign coop:")
                                Text("\(game.campaigncoop ? "YES" : "NO")")
                            }
                            Style.DividerView()
                            
                            VStack {
                                Text("Lan coop:")
                                Text("\(game.lancoop ? "YES" : "NO")")
                            }
                            Style.DividerView()
                        }
                        Group {
                            VStack {
                                Text("Offline coop:")
                                Text("\(game.offlinecoop ? "YES" : "NO")")
                                
                            }
                            if game.offlinecoop {
                                Style.DividerView()
                                
                                VStack {
                                    
                                    Text("Amount players:")
                                    Text("\(game.offlinecoopmax ?? 0)")
                                }
                            }
                            Style.DividerView()
                            
                            VStack {
                                Text("Online coop:")
                                Text("\(game.onlinecoop ? "YES" : "NO")")
                            }
                            if game.onlinecoop {
                                Style.DividerView()
                                
                                VStack {
                                    
                                    Text("Amount players:")
                                    Text("\(game.onlinecoopmax ?? 0)")
                                }
                            }
                            Style.DividerView()
                            
                            VStack {
                                Text("Splitscreen:")
                                Text("\(game.splitscreen ? "YES" : "NO")")
                            }
                            
                        }
                    }
                    
                }
                .padding(10)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(red: 74 / 255, green: 67 / 255, blue: 172 / 255))                 .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        }
    }
}
