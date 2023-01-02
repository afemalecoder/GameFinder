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
                        
                                PlayerPerspectiveView(currentGame: favGame)
                           
                                ModesView(currentgame: favGame)
                       
                                ThemeView(currentGame: favGame)
                      
                                GenreView(currentgame: favGame)
                            
                        }
                            
                                PlatformView(currentGame: favGame)
                        
                            
                            ScrollView(.horizontal) {
                                ScreenshotsView(currentGame: favGame)
                            }
                            .padding([.top, .bottom], 5)
                        
                        SteamRatingPriceView(games: games)
                        
                        Section {
                            SummaryView(favGame.summary ?? "N/A")
                        } header: {
                            Text("Story:")
                                .font(.system(size: 18))
                        }
                        
                        VideoViews(currentGame: favGame)
                            .padding([.top, .bottom], 15)
                        
                        MultiplayerView(currentGame: favGame)
                        
                        CompaniesView(currentGame: favGame)
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
                    print(games)
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
 
