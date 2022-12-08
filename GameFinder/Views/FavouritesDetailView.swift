//
//  FavoritesDetailView.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 05/12/2022.
//

import SwiftUI

struct FavouritesDetailView: View {
    var favorite: Favourites
    @State var games = [Steam]()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            LinearGradient(gradient: Gradient(colors: [Colors().backgroundColor,Colors().secondaryBackgroundColor ]), startPoint: .top, endPoint: .bottom)
            
            ScrollView {
                VStack(alignment: .leading) {
                    VStack {
                        HStack {
                            AsyncImage(url: URL(string: "https://images.igdb.com/igdb/image/upload/t_cover_big/\(favorite.cover ?? "N/A").jpg")) { image in
                                image
                                    .resizable()
                                    .frame(width: 100, height: 100)
                            } placeholder: {
                                Image("gamefinder")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                            }
                            
                            VStack(alignment: .leading) {
                                Text(favorite.name ?? "N/A")
                                    .font(.title2.bold())
                                    .foregroundColor(.white)
                                
                                Text("Release date: \(NSDate(timeIntervalSince1970: Double(favorite.firstReleaseDate)) as Date.FormatStyle.FormatInput, format: Date.FormatStyle().year().month().day())")
                                
                                Text(favorite.involvedCompanies ?? "N/A" )
                            }
                            Spacer()
                            Text("\((favorite.aggregatedRating),specifier: "%.2f")")
                                .font(.subheadline.bold())
                                .padding(15)
                                .foregroundColor(.white)
                                .background(.blue)
                                .clipShape(Circle())
                        }
                    }
                    VStack(alignment: .leading) {
                        Text(favorite.playerPerspective ?? "N/A")

                        Text(favorite.gameModes ?? "N/A")

                        Text(favorite.theme ?? "N/A")
                        Text("Genres: ")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)

//                        ScrollView(.horizontal){
//                            HStack {
//                                ForEach((favorite.genres?.prefix(999)) ?? [TheGame.Genre]().prefix(999)) { genre in
//                                    Text(genre.name)
//                                            .lineLimit(1)
//                                            .font(.subheadline.bold())
//                                            .foregroundColor(.white)
//                                            .padding(3)
//                                            .background(.blue)
//                                            .clipShape(RoundedRectangle(cornerRadius: 5))
//                                }
//                            }
//
//                        }
                    }
                    VStack(alignment: .leading) {
                        Text("Platform: ")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                        ScrollView(.horizontal){
//                            HStack {
//                                ForEach((favorite.platforms?.prefix(999) ?? [TheGame.Platform]().prefix(999))) { platform in
//                                    if platform.name == "PC (Microsoft Windows)" {
//                                        Text("PC ")
//                                            .scaledToFit()
//                                            .lineLimit(1)
//                                            .font(.subheadline)
//                                            .foregroundColor(.white)
//                                    }  else {
//                                        Text(platform.name)
//                                            .scaledToFit()
//                                            .lineLimit(1)
//                                            .font(.subheadline)
//                                            .foregroundColor(.white)
//
//                                    }
//
//                                }
//
//                            }
                        }
                    }
                    ScrollView(.horizontal) {
                        HStack {

                            AsyncImage(url: URL(string: "https://images.igdb.com/igdb/image/upload/t_thumb/\(favorite.screenshots).jpg")) { image in
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
//                    ScrollView(.horizontal){
//                        HStack {
//
//                                if favorite.videos == "Trailer"{
//                                    VideoView(videoID: video.video_id)
//                                        .frame(width: 200, height: 150)
//                                        .cornerRadius(12)
//                                } else {
//                                    VideoView(videoID: video.video_id)
//                                        .frame(width: 200, height: 150)
//                                        .cornerRadius(12)
//                                }
//
//                        }
//                    }
                    
                    Section {
                        Text(favorite.summary ?? "N/A")
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
//                    ForEach(favorite.multiplayerModes ?? [TheGame.Multiplayer]()) { game in
//                        Text("Got campaign coop:\(game.campaigncoop ? "YES" : "NO")")
//                        Text("Got lan coop:\(game.lancoop ? "YES" : "NO")")
//                        Text("Got offline coop:\(game.offlinecoop ? "YES" : "NO")")
//                        if game.offlinecoop {
//                            Text("Amount players: \(game.offlinecoopmax ?? 0)")
//                        }
//                        Text("Got online coop:\(game.onlinecoop ? "YES" : "NO")")
//                        if game.onlinecoop {
//                            Text("Amount players: \(game.onlinecoopmax ?? 0)")
//                        }
//                        Text("Got splitscreen:\(game.splitscreen ? "YES" : "NO")")
//                    }
                }
                .padding(.top, 100)
               
            }
            
            
            .onAppear() {
                Api().loadData(url: "https://www.cheapshark.com/api/1.0/deals?title=\(favorite.slug ?? "")") { games in
                    self.games = games
                }
            }
        }
        .ignoresSafeArea()
    }
}

struct FavoritesDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesDetailView(favorite: Favourites())
    }
}
