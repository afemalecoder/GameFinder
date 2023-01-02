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
            VStack(alignment: .leading, spacing: 4) {
                Text("Genres ")
                    .font(.system(size: 15).bold())
                    .foregroundColor(.gray)
                ScrollView(.horizontal) {
                    HStack {
                        ForEach((currentgame.genres?.prefix(genreAmount)) ?? [TheGame.Genre]().prefix(genreAmount)) { genre in
                            Text(genre.name)
                                .lineLimit(1)
                                .padding(10)
                                .background(Color(red: 74 / 255, green: 67 / 255, blue: 172 / 255))
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .font(.subheadline.bold())
                                .foregroundColor(Color.white)
                        }
                    }
                }
            }
        } else {
            VStack(alignment: .leading, spacing: 2) {
                Text("Genres ")
                    .font(.system(size: 15).bold())
                    .foregroundColor(.gray)
                Text("N/A")
                    .padding(10)
                    .background(Color(red: 74 / 255, green: 67 / 255, blue: 172 / 255))                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .font(.subheadline.bold())
                    .foregroundColor(Color.white)
            }
        }
            
    }
}
