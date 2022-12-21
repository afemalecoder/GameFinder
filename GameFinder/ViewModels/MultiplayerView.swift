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
                            Style.DividerView()
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
                            Style.DividerView()
                            
                        }
                    }
                    
                }
                .padding(10)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(red: 83 / 255, green: 83 / 255, blue: 181 / 255).opacity(0.5))
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        }
    }
}
