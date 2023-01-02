//
//  FavoritesDetailView.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 05/12/2022.
//

import SwiftUI

struct FavouritesDetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @Environment(\.openURL) var openURL
    @EnvironmentObject var networkFav: NetworkFavorite
    @Binding var game : TheGame?
    
    var favorite: Favourites
    
    @State private var showingDeleteAlert = false
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
                                CoverView(currentGame: favGame)
                                    .frame(width: 100, height: 100)
                                    .clipShape(RoundedRectangle(cornerRadius: 18))
                                
                                VStack(alignment: .leading) {
                                    Text(favGame.name ?? "N/A")
                                        .font(.title2.bold())
                                        .foregroundColor(.white)
                                    
                                    ReleaseDateView(currentGame: favGame)
                                }
                                
                                Spacer()
                            }
                        }
                        VStack(alignment: .leading) {
                            
                            
                            ModesView(currentgame: favGame)
                            
                            
                            GenreView(currentgame: favGame)
                            
                        }
                        
                        PlatformView(currentGame: favGame)
                        
                        
                        ScrollView(.horizontal) {
                            ScreenshotsView(currentGame: favGame)
                        }
                        .padding([.top, .bottom], 5)
                        
                        ForEach(games.prefix(1)) { game in
                            HStack(spacing: 2.0) {
                                VStack(alignment: .center){
                                    Text(" Rating percent: ")
                                        .font(.subheadline.bold())
                                    Text("\(game.steamRatingPercent)%")
                                }
                                Style.DividerView()
                                VStack(alignment: .center){
                                    Text(" Rating: ")
                                        .font(.subheadline.bold())
                                    Text("\(game.steamRatingText ?? "N/A")")
                                }
                                Style.DividerView()
                                VStack(alignment: .center) {
                                    Text(" Rating count: ")
                                        .font(.subheadline.bold())
                                    Text("\(game.steamRatingCount)")
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 5)
                            .padding(.vertical, 20)
                            .background(Color(red: 55 / 255, green: 55 / 255, blue: 128 / 255))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .onTapGesture {
                                openURL(URL(string: "http://store.steampowered.com/app/\(game.steamAppID ?? "")")!)
                            }
                        }
                        
                        Section {
                            SummaryView(favGame.summary ?? "N/A")
                        } header: {
                            Text("Summery")
                                .font(.system(size: 15).bold())
                                .foregroundColor(.gray)
                        }
                        
                        ThemeView(currentGame: favGame)
                        
                        PlayerPerspectiveView(currentGame: favGame)
                       
                        VideoViews(currentGame: favGame)
                            .padding([.top, .bottom], 15)
                        Group {
                            ForEach(games.prefix(1)) { game in
                                HStack(spacing: 10) {
                                    VStack {
                                        Text("Normal price:")
                                            .font(.title3.bold())
                                        Text("$\(game.normalPrice)")
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding(.horizontal, 5)
                                    .padding(.vertical, 20)
                                    .background(Color(red: 55 / 255, green: 55 / 255, blue: 128 / 255))
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                    .onTapGesture {
                                        openURL(URL(string: "http://store.steampowered.com/app/\(game.steamAppID ?? "")")!)
                                    }
                                    
                                    VStack {
                                        Text("Sale prices: ")
                                            .font(.title3.bold())
                                        if game.salePrice == game.normalPrice {
                                            Text("N/A")
                                        } else {
                                            Text("$\(game.salePrice)")
                                        }
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding(.horizontal, 5)
                                    .padding(.vertical, 20)
                                    .background(Color(red: 55 / 255, green: 55 / 255, blue: 128 / 255))
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                    .onTapGesture {
                                        openURL(URL(string: "http://store.steampowered.com/app/\(game.steamAppID ?? "")")!)
                                    }
                                }
                            }
                            MultiplayerView(currentGame: favGame)
                            
                            CompaniesView(currentGame: favGame)
                        }
                    }
                }
                .padding(.bottom, 50)
                .padding(.top, 80)
                .padding(10)
            }
            .onAppear() {
                networkFav.getFavoriteGames(favGameID: Int(favorite.id)){}
                Api().loadData(url: "https://www.cheapshark.com/api/1.0/deals?title=\(favorite.slug ?? "")") { games in
                    self.games = games
                }
            }
            .alert("Remove Game", isPresented: $showingDeleteAlert) {
                Button("Remove", role: .destructive, action: deleteGame)
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("Are you sure?")
            }
            .toolbar {
                Button {
                    showingDeleteAlert = true
                } label : {
                    Label("Remove this game", systemImage: "trash")
                }
            }
        }
        .ignoresSafeArea()
    }
    func deleteGame() {
        moc.delete(favorite)
        
        try? moc.save()
        dismiss()
    }
}

