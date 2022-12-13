//
//  GameView.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 28/11/2022.
//

import SwiftUI

struct GameView: View {
    let game: TheGame
    @State var games = [Steam]()
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                ScrollView {
                    VStack(alignment: .leading) {
                        VStack {
                            HStack {
                                CoverView(currentGame: game)
                                    .frame(width: 100, height: 100)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                
                                VStack(alignment: .leading) {
                                    Text(game.name ?? "N/A")
                                        .font(.title2.bold())
                                        .foregroundColor(.white)
                                    
                                    ReleaseDateView(currentGame: game)
                                }
                                
                                Spacer()
                                RatingView(currentGame: game)
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            
                            PlayerPerspectiveView(currentGame: game)
                            
                            GameModesView(currentgame: game)
                            
                            ThemeView(currentGame: game)
                            
                            Text("Genres:")
                                .font(.system(size: 15))
                                .foregroundColor(.gray)
                            ScrollView(.horizontal){
                                GenreView(currentgame: game)
                            }
                        }
                        
                        Text("Platform: ")
                            .font(.system(size: 15))
                            .foregroundColor(.gray)
                        ScrollView(.horizontal){
                            PlatformView(currentGame: game)
                        }
                        
                        
                        ScrollView(.horizontal) {
                            ScreenshotsView(currentGame: game)
                        }
                        .padding([.top, .bottom], 5)
                        
                        ForEach(games.prefix(1)) { game in
                            HStack(spacing: 15) {
                                VStack {
                                    Text("Normal price:")
                                        .font(.title3.bold())
                                    Text("\(game.normalPrice)$")
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal, 5)
                                .padding(.vertical, 20)
                                .background(Color(red: 55 / 255, green: 55 / 255, blue: 128 / 255))
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                
                                VStack {
                                    Text("Sale prices: ")
                                        .font(.title3.bold())
                                    if game.salePrice == game.normalPrice {
                                        Text("N/A")
                                    } else {
                                        Text("\(game.salePrice)$")
                                    }
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal, 5)
                                .padding(.vertical, 20)
                                .background(Color(red: 55 / 255, green: 55 / 255, blue: 128 / 255))
                                .clipShape(RoundedRectangle(cornerRadius: 20))
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
                        }
                        .padding(.bottom, 15)
                        
                        Section {
                            Text(game.summary ?? "N/A")
                                .font(.title3)
                                .foregroundColor(.white)
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
