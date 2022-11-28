//
//  GameView.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 28/11/2022.
//

import SwiftUI

struct GameView: View {
    let game: TheGames
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Colors().backgroundColor,Colors().secondaryBackgroundColor ]), startPoint: .top, endPoint: .bottom)
            VStack {
                AsyncImage(url: URL(string: "https://images.igdb.com/igdb/image/upload/t_cover_big/\(game.cover?.image_id ?? "N/A").jpg")) { image in
                    image
                        .resizable()
                        .frame(width: 330, height: 320)
                } placeholder: {
                    Image("gameFinder")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 330, height: 330)
                }
                Text(game.name)
                    .lineLimit(2)
                    .font(.title2.bold())
                    .foregroundColor(.white)
               
                HStack {
                    ForEach((game.genres?.prefix(2))!) { genre in
                        Text(genre.name)
                                .lineLimit(1)
                                .font(.subheadline.bold())
                                .foregroundColor(.white)
                                .padding(3)
                                .background(.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                        
                    }
                }
                HStack {
                    ForEach((game.platforms?.prefix(4))!) { platform in
                        if platform.name == "PC (Microsoft Windows)" {
                            Text("PC")
                                .scaledToFit()
                                .lineLimit(1)
                                .font(.subheadline)
                                .foregroundColor(.white)
                        } else {
                            Text(platform.name)
                                .scaledToFit()
                                .lineLimit(1)
                                .font(.subheadline)
                                .foregroundColor(.white)
                        }
                    }
                }
                Text(game.summary ?? "N/A")
                    .font(.title3)
                    .foregroundColor(.white)
                    .padding(.top, 5)
            }
        }
        .ignoresSafeArea()
    }
}

//struct GameView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameView(game: [TheGames]())
//    }
//}
