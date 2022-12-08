//
//  GameView.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 28/11/2022.
//

import SwiftUI

struct GameView: View {
    let game: TheGame
    let dateFormatter = Date()
    @State var games = [Steam]()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            LinearGradient(gradient: Gradient(colors: [Colors().backgroundColor,Colors().secondaryBackgroundColor ]), startPoint: .top, endPoint: .bottom)
            
            ScrollView {
                VStack(alignment: .leading) {
                    VStack {
                        HStack {
                            CoverView(currentGame: game)
                                .frame(width: 100, height: 100)
                            
                            VStack(alignment: .leading) {
                                Text(game.name ?? "N/A")
                                    .font(.title2.bold())
                                    .foregroundColor(.white)
                                
                                Text("Release date: \(NSDate(timeIntervalSince1970: Double(game.first_release_date ?? 0)) as Date.FormatStyle.FormatInput, format: Date.FormatStyle().year().month().day())")
                                
                                Text(game.involved_companies?[0].company.name ?? "N/A" )
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
                        ForEach(game.player_perspectives ?? [TheGame.Perspective]()) { perspective in
                            Text(perspective.name)
                        }
                        GameModesView(currentgame: game)
                        
                        ForEach(game.themes ?? [TheGame.Themes]()) { game in
                            Text("\(game.name)")
                        }
                        
                        Text("Genres: ")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                        
                        ScrollView(.horizontal){
                            GenreView(currentgame: game)
                        }
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
                                        .cornerRadius(12)
                                } placeholder: {
                                    Image("gameFinder")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                        .cornerRadius(12)
                                }
                            }
                        }
                    }
                    ScrollView(.horizontal){
                        HStack {
                            ForEach(game.videos ?? [TheGame.Video]()) { video in
                                if video.name == "Trailer"{
                                    VideoView(videoID: video.video_id)
                                        .frame(width: 200, height: 150)
                                        .cornerRadius(12)
                                } else {
                                    VideoView(videoID: video.video_id)
                                        .frame(width: 200, height: 150)
                                        .cornerRadius(12)
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
                    ForEach(games.prefix(1)) { game in
                        Text("Title: \(game.title)")
                        Text("Normal price: \(game.normalPrice)")
                        Text("Sale prices: \(game.salePrice)")
                        Text("Steam rating percent: \(game.steamRatingPercent)")
                        Text("Steam rating text: \(game.steamRatingText ?? "N/A")")
                        Text("Steam rating count: \(game.steamRatingCount)")
                    }
                    ForEach(game.multiplayer_modes ?? [TheGame.Multiplayer]()) { game in
                        Text("Got campaign coop:\(game.campaigncoop ? "YES" : "NO")")
                        Text("Got lan coop:\(game.lancoop ? "YES" : "NO")")
                        Text("Got offline coop:\(game.offlinecoop ? "YES" : "NO")")
                        if game.offlinecoop {
                            Text("Amount players: \(game.offlinecoopmax ?? 0)")
                        }
                        Text("Got online coop:\(game.onlinecoop ? "YES" : "NO")")
                        if game.onlinecoop {
                            Text("Amount players: \(game.onlinecoopmax ?? 0)")
                        }
                        Text("Got splitscreen:\(game.splitscreen ? "YES" : "NO")")
                    }
                }
                .padding(10)
                .padding(.bottom, 100)
            }
            
            
            .onAppear() {
                Api().loadData(url: "https://www.cheapshark.com/api/1.0/deals?title=\(game.slug ?? "")") { games in
                    self.games = games
                }
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
