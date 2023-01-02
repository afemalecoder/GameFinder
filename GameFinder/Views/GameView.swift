//
//  GameView.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 28/11/2022.
//

import SwiftUI

struct GameView: View {
    @State var game: TheGame
    @State var games = [Steam]()
    @Environment(\.openURL) var openURL

    
    var body: some View {
        NavigationStack {
            
            ZStack(alignment: .bottom) {
                ScrollView {
                    VStack(alignment: .leading) {
                        VStack {
                            HStack {
                                CoverView(currentGame: game)
                                    .frame(width: 100, height: 100)
                                    .clipShape(RoundedRectangle(cornerRadius: 18))
                                
                                VStack(alignment: .leading) {
                                    Text(game.name ?? "N/A")
                                        .font(.title2.bold())
                                        .foregroundColor(.white)
                                    
                                    ReleaseDateView(currentGame: game)
                                }        
                                Spacer()
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            
                                PlayerPerspectiveView(currentGame: game)
                            
                                ModesView(currentgame: game)
                            
                                ThemeView(currentGame: game)
                           
                                GenreView(currentgame: game)
                        }
                        
                            PlatformView(currentGame: game)
                        
                        ScrollView(.horizontal) {
                            ScreenshotsView(currentGame: game)
                        }
                        .padding([.top, .bottom], 5)
                        
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
                        .padding(.bottom, 15)
                        Section {
                            SummaryView(game.summary ?? "N/A")
                        } header: {
                            Text("Story:")
                                .font(.system(size: 18))
                        }
                        
                        VideoViews(currentGame: game)
                            .padding([.top, .bottom], 15)
                        
                        MultiplayerView(currentGame: game)
                        
                        CompaniesView(currentGame: game)

                    }
                    .padding(10)
                    .padding(.bottom, 120)
                }
                .onAppear() {
                    Api().loadData(url: "https://www.cheapshark.com/api/1.0/deals?title=\(game.slug ?? "")") { games in
                        self.games = games
                        
                    }
                }
            }
            .background(Colors().backgroundColor)
            .ignoresSafeArea()
        }
    }
}
