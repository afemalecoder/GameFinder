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

        if currentgame.genres != nil {
            VStack(alignment: .leading, spacing: 0) {
                Text("Genres: ")
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
                ScrollView(.horizontal) {
                    HStack {
                        ForEach((currentgame.genres?.prefix(genreAmount)) ?? [TheGame.Genre]().prefix(genreAmount)) { genre in
                            Text(genre.name)
                                .lineLimit(1)
                                .padding(5)
                                .background(Color(red: 83 / 255, green: 83 / 255, blue: 181 / 255))
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                .font(.subheadline.bold())
                                .foregroundColor(.white)
                        }
                    }
                }
            }
        } else {
            Text("N/A")
        }
            
    }
}
