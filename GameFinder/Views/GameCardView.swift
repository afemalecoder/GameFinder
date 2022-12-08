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
            .padding(50)
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
                CoverView(currentGame: games, coverSize: 330)
                cardText
            }
            .frame(width: 300, height: 500)
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 8)
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
                HStack(alignment: .bottom) {
                    Text(games.name ?? "N/A")
                        .lineLimit(2)
                        .font(.title2.bold())
                        .foregroundColor(.white)
                }
                .padding(.bottom, 1)
                VStack(alignment: .leading, spacing: 1.0) {
                    PlatformView(currentGame: games, amount: 4)
                    
                    GenreView(currentgame: games, genreAmount: 2)
                    
                    GameModesView(currentgame: games)
                    
                    Text(games.summary ?? "N/A")
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(.top, 5)
                    Spacer()
                }
            }
            .padding(.leading, 20)
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

//
//struct GameCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameCardView()
//    }
//}
