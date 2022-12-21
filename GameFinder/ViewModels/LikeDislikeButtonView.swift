//
//  LikeDislikeButtonView.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 01/12/2022.
//

import SwiftUI

struct LikeDislikeButtonView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    var games: TheGame
    var onRemove: (_ game: TheGame) -> Void
    
    var body: some View {
       
            HStack {
                    Button(action: {
                       
                        self.onRemove(self.games)
                        dismiss()
                    }) {
                       
                        Image(systemName: "xmark")
                            .font(.system(size: 50))
                            .padding(10)
                            .background(Color(red: 251 / 255, green: 119 / 255, blue: 133 / 255))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .foregroundColor(.white)
                            .padding(10)
                    }
                
                Button {
                    FavouriteGame(games: games, newFav: Favourites(context: moc))
                    
                    self.onRemove(self.games)
                    dismiss()
                    try? moc.save()
                } label: {
                    Image(systemName: "heart.fill")
                        .font(.system(size: 45))
                        .padding(10)
                        .background(Color(red: 106 / 255, green: 103 / 255, blue: 244 / 255))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .foregroundColor(.white)
                        .padding(10)
                }
            }
    }
}
