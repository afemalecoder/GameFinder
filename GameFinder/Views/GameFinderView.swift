//
//  GameFinderView.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 03/11/2022.
//

import SwiftUI

struct GameFinderView: View {
    @EnvironmentObject var network: Network
    
    var body: some View {
        NavigationStack{
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Colors().backgroundColor,Colors().secondaryBackgroundColor ]), startPoint: .top, endPoint: .bottom)
                
                List {
                    ForEach(network.games) { game in
                        VStack(alignment: .leading) {
                            
                            AsyncImage(url: URL(string: "https:\(game.cover?.url ?? "N/A")")) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                            } placeholder: {
                                Color.blue
                            }
                            .frame(width: 200, height: 200)
                            
                            Text(game.name)
                                .font(.headline.bold())
                            Text(game.summary ?? "")
                            
                            ForEach(game.genres ?? [Games.Genre]()) { genre in
                                Text("\(genre.name)")
                                    .background(.red)
                            }
                            ForEach(game.platforms ?? [Games.Platform]()) { platform in
                                Text("\(platform.name)")
                                    .background(.purple)
                            }
                        }
                    }
                }
                .ignoresSafeArea()
            }
        }
        .onAppear{
            network.getGames()
        }
    }
}

struct GameFinderView_Previews: PreviewProvider {
    static var previews: some View {
        GameFinderView().environmentObject(Network())
    }
}
