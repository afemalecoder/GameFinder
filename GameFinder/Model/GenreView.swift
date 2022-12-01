//
//  GenreView.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 28/11/2022.
//

import SwiftUI

struct GenreView: View {
    
    @State var currentgame : TheGame
    @State var genreAmount = 999
    
    var body: some View {
        HStack {
            ForEach((currentgame.genres?.prefix(genreAmount))!) { genre in
                Text(genre.name)
                        .lineLimit(1)
                        .font(.subheadline.bold())
                        .foregroundColor(.white)
                        .padding(3)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
            }
        }
    }
}

/*
struct GenreView_Previews: PreviewProvider {
    static var previews: some View {
        GenreView(currentgame: TheGames())
    }
}
*/
