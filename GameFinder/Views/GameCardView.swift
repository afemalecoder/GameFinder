//
//  GameCardView.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 21/11/2022.
//

import SwiftUI

struct GameCardView: View {
    @EnvironmentObject var network: Network
    @Binding var currentgame : TheGame?

    var body: some View {
        NavigationStack {
                GeometryReader { geometry in
                    ZStack {
                        ForEach(network.games) { game in
                            
                            TheCard(games: game, onRemove: { removedGame in
                                network.games.removeAll { $0.id == removedGame.id}
                                self.currentgame = network.games.last
                                if network.games.count == 0 {
                                    network.getGames(){
                                        currentgame = network.games.last
                                    }
                                }
                            })
                            .frame(minWidth: geometry.size.width, minHeight: geometry.size.height, alignment: .center)
                        }
                    }
                }
            }
            .onAppear{
                network.getGames() {
                    currentgame = network.games.last
                }
        }
    }
}


struct TheCard: View {
    
    @State private var translation: CGSize = .zero
    
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var network: Network
    
  
    @State var games: TheGame?
    var onRemove: (_ game: TheGame) -> Void
    var thresholdPrecentage: CGFloat = 0.5
    
    @State var color = Colors().backgroundColor
    
    init(games: TheGame, onRemove: @escaping(_ games: TheGame) -> Void) {
        self.games = games
        self.onRemove = onRemove
    }
    
    private func getGesturePercentage(_ geometry: GeometryProxy, from gesture: DragGesture.Value) -> CGFloat {
        gesture.translation.width / geometry.size.width
    }
    
    var body: some View {

        GeometryReader { geometry in
         
                VStack {
                    
                    CoverView(currentGame: games!, coverSizeWidth: .maximum(.infinity, .infinity), coverSizeHeight: 330)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    cardText
                }
                .background(color)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .offset(x: self.translation.width, y: 0)
                .rotationEffect(.degrees(Double(self.translation.width / geometry.size.width) * 10), anchor: .center)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                                self.translation = value.translation
                                
                        }
                        .onEnded { value in

                            if abs(self.getGesturePercentage(geometry, from: value)) > self.thresholdPrecentage {
                               
                                self.onRemove(self.games!)
                                if(value.translation.width > -50){
                                    FavouriteGame(games: games!, newFav: Favourites(context: moc))
                                    try? moc.save()
                                }
                            } else {
                                    self.translation = .zero
                            }
                        }
                )
            .ignoresSafeArea()
        }
    }
    var cardText: some View {
        VStack(alignment: .leading, spacing: 4.0) {
            HStack(alignment: .bottom){
                    Text(games!.name ?? "N/A")
                        .lineLimit(2)
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.white)
                }
                VStack(alignment: .leading, spacing: 4.0) {
                    
                    GenreView(currentgame: games!, genreAmount: 2).scrollDisabled(true)
                    
                    PlatformView(currentGame: games!, amount: 3).scrollDisabled(true)
                    
                   Text(games!.summary ?? "N/A")
                        .lineLimit(4)
                        .font(.system(size: 15))
                        .foregroundColor(.white)
                        .padding(.top, 10)
                        Spacer()
                }
            }
            .padding([.leading, .trailing], 10)
        }
    }
