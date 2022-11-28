//
//  GameView.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 28/11/2022.
//

import SwiftUI

struct GameView: View {
    let game: TheGame
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Colors().backgroundColor,Colors().secondaryBackgroundColor ]), startPoint: .top, endPoint: .bottom)
            ScrollView {
                VStack(alignment: .leading) {
                    VStack {
                        HStack {
                            CoverView(currentGame: game)
                                .frame(width: 100, height: 100)
                            
                            VStack(alignment: .leading) {
                                Text(game.name)
                                    .font(.title2.bold())
                                    .foregroundColor(.white)
                                
                                ForEach((game.release_dates?.prefix(1))!) { date in
                                    Text("Release date: \(date.y), \(date.m)")
                                }
                                Text(game.involved_companies![0].company.name)
                            }
                            Spacer()
                            Text("\((game.aggregated_rating ?? 0.0),specifier: "%.2f")")
                                .font(.subheadline.bold())
                                .padding(15)
                                .foregroundColor(.white)
                                .background(.blue)
                                .clipShape(Circle())
                        }
                    }
                    VStack(alignment: .leading) {
                        Text("Genres: ")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                        
                        GenreView(currentgame: game)
                    }
                    VStack(alignment: .leading) {
                        Text("Platform: ")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                        ScrollView(.horizontal){
                            PlatformView(currentGame: game)
                        }
                    }
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(game.screenshots ?? [TheGame.Screenshots]()) { screenshot in
                                AsyncImage(url: URL(string: "https://images.igdb.com/igdb/image/upload/t_thumb/\(screenshot.image_id).jpg")) { image in
                                    image
                                        .resizable()
                                        .frame(width: 150, height: 150)
                                } placeholder: {
                                    Image("gameFinder")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                }
                            }
                        }
                    }
                    Section {
                        Text(game.summary ?? "N/A")
                            .font(.title3)
                            .foregroundColor(.white)
                    } header: {
                        Text("Story:")
                    }
                }
            }
            .padding(20)
        }
        .ignoresSafeArea()
    }
}

//struct GameView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameView(game: [TheGames]())
//    }
//}
