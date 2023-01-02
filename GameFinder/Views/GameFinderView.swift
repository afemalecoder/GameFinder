//
//  GameFinderView.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 03/11/2022.
//

import SwiftUI

struct GameFinderView: View {
    @EnvironmentObject var network: Network
    @State var game : TheGame?
    @State private var hasTimeElapsed = false
    @State private var loadText = false
    @State private var showGame = false

    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Colors().backgroundColor,Colors().secondaryBackgroundColor ]), startPoint: .top, endPoint: .bottom)
                    
                    VStack() {
                        
                        GameCardView(currentgame: $game)
                            .onTapGesture {
                                showGame = true
                            }
                            .sheet(isPresented: $showGame) {
                                ZStack(alignment: .bottom) {
                                    GameView(game: game!)
                                    LikeDislikeButtonView(games: $game, onRemove: { removedGame in
                                        network.games.removeAll { $0.id == removedGame.id}
                                            game = network.games.last
                                        
                                        if network.games.count == 0 {
                                            network.getGames() {}
                                        }
                                    })
                                }
                            }
                            .padding(.bottom, 20)
                        if game != nil {
                            LikeDislikeButtonView(games: $game, onRemove: { removedGame in
                                network.games.removeAll { $0.id == removedGame.id }
                                self.game = network.games.last
                                if network.games.count == 0 {
                                    network.getGames() {
                                        game = network.games.last
                                    }
                                }
                            })
                            
                        } else {
                                
                                ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .purple))
                                .frame(width: 200, height: 200)
                                   
                            }
                            }
                            
                            
                            .progressViewStyle(.circular)
                            .padding(.top, geometry.size.height * 0.2)
                            .padding(.bottom, geometry.size.height * 0.09)
                            .padding([.leading, .trailing], geometry.size.width * 0.09)
                            
                        }
                            .toolbar() {
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    NavigationLink(destination: FavouritesView()){
                                        Image(systemName: "heart.fill")
                                            .font(.system(size: 30))
                                            .foregroundColor(Color(red: 251 / 255, green: 119 / 255, blue: 133 / 255))
                                            .padding([.trailing, .bottom], 15)
                                            .padding(.top, 25)
                                    }
                                }
                            }
                            .ignoresSafeArea()
                    }
                }
            }
            
        }
