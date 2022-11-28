//
//  GameFinderView.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 03/11/2022.
//

import SwiftUI

struct GameFinderView: View {
    @EnvironmentObject var network: Network
    @State private var showGame = false
    
    var body: some View {
        NavigationStack{
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Colors().backgroundColor,Colors().secondaryBackgroundColor ]), startPoint: .top, endPoint: .bottom)
                
                    GameCardView()
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
