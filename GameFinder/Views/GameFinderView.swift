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
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Colors().backgroundColor,Colors().secondaryBackgroundColor ]), startPoint: .top, endPoint: .bottom)
                VStack {
                    
                    GameCardView(currentgame: $game)
                        .padding(.top, 110)
                    
                    if game != nil {
                        LikeDislikeButtonView(games: game!, onRemove: { removedGame in
                            network.games.removeAll { $0.id == removedGame.id}
                            game = network.games.last
                            if network.games.count == 0 {
                                network.getGames() {}
                            }
                        })
                        .padding(.bottom, 45)
                    }
                }
                
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
