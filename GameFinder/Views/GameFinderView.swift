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
                VStack {
                    ForEach(network.games) { game in
                        VStack(alignment: .leading) {
                            Text(game.name)
                            Text(game.summary ?? "")
                            Text("\(game.genres)" as String)
                        }
                    }
                }
            }
            .ignoresSafeArea()
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
