//
//  GameFinderView.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 03/11/2022.
//

import SwiftUI

struct GameFinderView: View {
    @EnvironmentObject var network: Network
    @State private var name: String = ""
    
    var body: some View {
        NavigationStack{
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Colors().backgroundColor,Colors().secondaryBackgroundColor ]), startPoint: .top, endPoint: .bottom)
                VStack {
                    ForEach(network.games) { game in
                        HStack(alignment: .top) {
                            Text("\(game.id)")
                            Text(game.name)
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
    struct Genre: Codable {
        let value: String
    }
}

struct GameFinderView_Previews: PreviewProvider {
    static var previews: some View {
        GameFinderView().environmentObject(Network())
    }
}
