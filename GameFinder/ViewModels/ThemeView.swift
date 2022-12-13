//
//  ThemeView.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 13/12/2022.
//

import SwiftUI

struct ThemeView: View {
  
    @State var currentGame : TheGame
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Themes: ")
                .font(.system(size: 12))
                .foregroundColor(.gray)
            if currentGame.themes != nil {
                HStack {
                    ForEach(currentGame.themes ?? [TheGame.Themes]()) { game in
                        Text("\(game.name)")
                        
                    }
                }
            } else {
                Text("N/A")
            }
        }
    }
}
