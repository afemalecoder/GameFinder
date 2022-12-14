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
    
    private func getCardWidth(_ geometry: GeometryProxy, id: Int) -> CGFloat {
        let offset: CGFloat = CGFloat(network.games.count) * 5
        return geometry.size.width - offset
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                GeometryReader { geometry in
                    ZStack {
                        ForEach(network.games) { game in
                            
                            TheCard(games: game, onRemove: { removedGame in
                                network.games.removeAll { $0.id == removedGame.id}
                                currentgame = network.games.last
                                if network.games.count == 0 {
                                    network.getGames(){
                                        currentgame = network.games.last
                                    }
                                }
                            })
                            .frame(minWidth: self.getCardWidth(geometry, id: game.id), minHeight: geometry.size.height, alignment: .leading)
                        }
                    }
                }
            }
            .padding(35)
            .onAppear{
                network.getGames() {
                    currentgame = network.games.last
                    
                }
            }
        }
    }
}

struct TheCard: View {
    
    @State private var translation: CGSize = .zero
    @State private var showGame = false
    
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var network: Network
    
    var games: TheGame
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
            VStack(alignment: .leading) {
                CoverView(currentGame: games, coverSizeWidth: 350, coverSizeHeight: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                cardText
            }
            .frame(width: 350, height: 560)
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .offset(x: self.translation.width, y: self.translation.height)
            .rotationEffect(.degrees(Double(self.translation.width / geometry.size.width) * 10), anchor: .bottom)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        self.translation = value.translation
                        withAnimation {
                            likeDislikeSwipe(width: self.translation.width)
                        }
                    } .onEnded { value in
                        if abs(self.getGesturePercentage(geometry, from: value)) > self.thresholdPrecentage {
                            
                            self.onRemove(self.games)
                            if(value.translation.width > -50){
                                FavouriteGame(games: games, newFav: Favourites(context: moc))
                                try? moc.save()
                            }
                            withAnimation {
                                likeDislikeSwipe(width: self.translation.width)
                            }
                        } else {
                            withAnimation{
                                
                                self.translation = .zero
                            }
                        }
                    }
            )
            .onTapGesture {
                showGame = true
            }
            .sheet(isPresented: $showGame) {
                ZStack(alignment: .bottom) {
                    GameView(game: games)
                    LikeDislikeButtonView(games: games, onRemove: { removedGame in
                        network.games.removeAll { $0.id == removedGame.id}
                        if network.games.count == 0 {
                            network.getGames() {}
                        }
                    })
                }
            }
            .ignoresSafeArea()
        }
        
    }
    var cardText: some View {
        
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(games.name ?? "N/A")
                        .lineLimit(2)
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.white)
                }
                VStack(alignment: .leading, spacing: 3.0) {
                    
                    GenreView(currentgame: games, genreAmount: 2).scrollDisabled(true)
                    
                    PlatformView(currentGame: games, amount: 3).scrollDisabled(true)
                    
                    
                   Text(games.summary ?? "N/A")
                        .lineLimit(4)
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding([.top, .bottom], 2)
                    Spacer()
                }
            }
            .padding([.leading, .trailing], 10)
        }
    }
    
    //Change to animation
    func likeDislikeSwipe(width: CGFloat) {
        switch width {
        case -500...(-130):
            color = .red
        case 130...500 :
            color = .green
        default :
            color = Colors().backgroundColor
        }
    }
}
