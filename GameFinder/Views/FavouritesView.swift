//
//  FavoritesView.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 05/12/2022.
//
import CoreData
import SwiftUI

struct FavouritesView: View {
    @State var game : TheGame?
    var networkFav = NetworkFavorite()
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var favourites: FetchedResults<Favourites>
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Colors().backgroundColor,Colors().secondaryBackgroundColor ]), startPoint: .top, endPoint: .bottom)
                
                    List {
                        ForEach(favourites, id: \.self) { favourite in
                            NavigationLink {
                                FavouritesDetailView(game: $game, favorite: favourite).environmentObject(networkFav)
                            } label: {
                                HStack {
                                    AsyncImage(url: URL(string: "https://images.igdb.com/igdb/image/upload/t_cover_big/\(favourite.cover ?? "N/A").jpg")) { image in
                                        image
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                    } placeholder: {
                                        Image("gamefinder")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                    }
                    
                                    Text(favourite.name ?? "N/A")
                                }
                            }
                        }
                        
                        .onDelete(perform: deleteGame)
                        .listRowBackground(Colors().backgroundColor)

                    }
                    
                    .padding(.top, 70)
                    .navigationBarTitle("Favorites")
                    .scrollContentBackground(.hidden)
                    
            }
            .ignoresSafeArea()
        }
    }
 
    
    func deleteGame(at offsets: IndexSet) {
        for offset in offsets {
            let game = favourites[offset]
            moc.delete(game)
        }
        try? moc.save()
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView()
    }
}
