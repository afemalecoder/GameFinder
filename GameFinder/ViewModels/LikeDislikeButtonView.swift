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
                        FavouriteGame(games: games, newFav: Favourites(context: moc))
                        
                        self.onRemove(self.games)
                        dismiss()
                        try? moc.save()
                        
                    }) {
                        Label("Like ",systemImage: "heart")
                            .fontWeight(.bold)
                            .font(.title)
                            .padding(10)
                            .background(.blue.opacity(0.4))
                            .clipShape(RoundedRectangle(cornerRadius: 40))
                            .foregroundColor(.blue)
                            .padding(10)
                    }
                
                Button {
                    self.onRemove(self.games)
                    dismiss()
                } label: {
                    Label("Dislike", systemImage: "hand.thumbsdown")
                        .fontWeight(.bold)
                        .font(.title)
                        .padding(10)
                        .background(.blue.opacity(0.4))
                        .clipShape(RoundedRectangle(cornerRadius: 40))
                        .foregroundColor(.blue)
                        .padding(10)
                }
            }
    }
}

//struct LikeDislikeButtonView_Previews: PreviewProvider {
//    static var previews: some View {
//        LikeDislikeButtonView()
//    }
//}
