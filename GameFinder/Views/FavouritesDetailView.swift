//
//  FavoritesDetailView.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 05/12/2022.
//

/*
 TODO:
 - API call get: genres, game_mode, involved_companies, multiplayer_modes, platforms, player_perspective, screenshots, theme and video
 */
import SwiftUI

struct FavouritesDetailView: View {
    @EnvironmentObject var networkFav: NetworkFavorite
    @Binding var game : FavoriteGameStruct?
    
    var favorite: Favourites
    
    @State private var isImageTapped = false
    @State var games = [Steam]()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            LinearGradient(gradient: Gradient(colors: [Colors().backgroundColor,Colors().secondaryBackgroundColor ]), startPoint: .top, endPoint: .bottom)
            
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(networkFav.games) { favGame in
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
                                    Text(favorite.name ?? "")
                                        .font(.title2.bold())
                                        .foregroundColor(.white)
                                    
                                    Text("Release date: \(NSDate(timeIntervalSince1970: Double(favorite.firstReleaseDate)) as Date.FormatStyle.FormatInput, format: Date.FormatStyle().year().month().day())")
                                    
                                    //                                ForEach(networkFav.games) { favoriteGame in
                                    //                                    Text("\(favoriteGame.involved_companies ?? [FavoriteGameStruct.Companies]())")
                                    //                                }
                                }
                                
                                Text("\((favorite.aggregatedRating),specifier: "%.2f")")
                                    .font(.subheadline.bold())
                                    .padding(15)
                                    .foregroundColor(.white)
                                    .background(.blue)
                                    .clipShape(Circle())
                            }
                        }
                        VStack(alignment: .leading) {
                            
                            ForEach(favGame.player_perspectives ?? [FavoriteGameStruct.Perspective]()) { game in
                                Text("\(game.name)")
                            }
                            ForEach(favGame.game_modes ?? [FavoriteGameStruct.Modes]()) { game in
                                Text("\(game.name)")
                                
                            }
                            ForEach(favGame.themes ?? [FavoriteGameStruct.Themes]()) { game in
                                Text("\(game.name)")
                                
                            }
                            Text("Genres: ")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                            
                            ScrollView(.horizontal){
                                HStack {
                                    ForEach(favGame.genres?.prefix(999) ?? [FavoriteGameStruct.Genre]().prefix(999)) { genre in
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
                            VStack(alignment: .leading) {
                                Text("Platform: ")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                                ScrollView(.horizontal){
                                    HStack {
                                        ForEach(favGame.platforms?.prefix(999) ?? [FavoriteGameStruct.Platform]().prefix(999)) { platform in
                                            if platform.name == "PC (Microsoft Windows)" {
                                                Text("PC ")
                                                    .scaledToFit()
                                                    .lineLimit(1)
                                                    .font(.subheadline)
                                                    .foregroundColor(.white)
                                            }  else {
                                                Text(platform.name)
                                                    .scaledToFit()
                                                    .lineLimit(1)
                                                    .font(.subheadline)
                                                    .foregroundColor(.white)
                                            }
                                        }
                                    }
                                }
                            }
                            ScrollView(.horizontal){
                                HStack {
                                    ForEach(favGame.screenshots ?? [FavoriteGameStruct.Screenshots]()) { screenshot in
                                        
                                        AsyncImage(url: URL(string: "https://images.igdb.com/igdb/image/upload/t_screenshot_big/\(screenshot.image_id).jpg")) { image in
                                            image
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 150, height: 100)
                                                .cornerRadius(12)
                                        } placeholder: {
                                            Image("gamefinder")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 100, height: 100)
                                                .cornerRadius(12)
                                        }
                                    }
                                }
                                .onTapGesture{
                                    isImageTapped.toggle()
                                    
                                }
                                NavigationLink("", destination: FavImageSliderView(imageURL: favGame), isActive: $isImageTapped)
                            }
                            ScrollView(.horizontal){
                                HStack {
                                    ForEach(favGame.videos ?? [FavoriteGameStruct.Video]()) { video in
                                        if video.name == "Trailer" {
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
                                Text(favorite.summary ?? "N/A")
                                    .font(.title3)
                                    .foregroundColor(.white)
                            } header: {
                                Text("Story:")
                            }
//                            ForEach(games.prefix(1)) { game in
//                                Text("Title: \(game.title)")
//                                Text("Normal price: \(game.normalPrice)")
//                                Text("Sale prices: \(game.salePrice)")
//                                Text("Steam rating percent: \(game.steamRatingPercent)")
//                                Text("Steam rating text: \(game.steamRatingText ?? "N/A")")
//                                Text("Steam rating count: \(game.steamRatingCount)")
//                            }
                            
                            ForEach(favGame.multiplayer_modes ?? [FavoriteGameStruct.Multiplayer]()) { game in
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
                    }
                }
                .padding(.top, 100)
                .padding(10)
            }
            .onAppear() {
                networkFav.getFavoriteGames(favGameID: Int(favorite.id)){}
                Api().loadData(url: "https://www.cheapshark.com/api/1.0/deals?title=\(favorite.slug ?? "")") { games in
                    self.games = games
                }
            }
        }
        .ignoresSafeArea()
    }
}
struct FavImageSliderView: View {
    let imageURL: FavoriteGameStruct
    private let timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()
    @State private var currentIndex = 0
    
    var body: some View {
            TabView(selection: $currentIndex) {
                ForEach(imageURL.screenshots ?? [FavoriteGameStruct.Screenshots]()) { screenshot in
                    AsyncImage(url: URL(string: "https://images.igdb.com/igdb/image/upload/t_screenshot_big/\(screenshot.image_id).jpg")) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 450, height: 400)
                            .cornerRadius(12)
                    } placeholder: {
                        Image("gameFinder")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                            .cornerRadius(12)
                    }
                }
            }
            .background(Colors().backgroundColor)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
}
//
//struct FavoritesDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        FavouritesDetailView(favorite: Favourites())
//    }
//}
