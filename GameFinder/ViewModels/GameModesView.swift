//
//  GameModesView.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 01/12/2022.
//

import SwiftUI

struct GameModesView: View {
    @State var currentgame : TheGame

    var body: some View {
        ForEach(currentgame.game_modes ?? [TheGame.Modes]()) { game in
            Text("\(game.name)")
        }
    }
}

//struct GameModesView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameModesView()
//    }
//}
