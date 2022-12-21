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
                        
                        SteamRatingPriceView(games: games)
                        
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
