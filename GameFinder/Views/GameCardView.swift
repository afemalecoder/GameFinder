//
//  GameCardView.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 21/11/2022.
//

import SwiftUI

struct GameCardView: View {
    
    @EnvironmentObject var network: Network

    
    private func getCardWidth(_ geometry: GeometryProxy, id: Int) -> CGFloat {
        let offset: CGFloat = CGFloat(network.games.count) * 5
        return geometry.size.width - offset
    }
    //    private func getCardOffset(_ geometry: GeometryProxy, id: Int) -> CGFloat {
    //        return  CGFloat(network.games.count)
    //    }
    //    private var maxID: Int {
    //        return network.games.map { $0.id }.max() ?? 0
    //    }
    
    var body: some View {
        NavigationStack {
            VStack() {
                GeometryReader { geometry in
                    ZStack {
                        ForEach(network.games) { game in
                            theCard(games: game, onRemove: { removedGame in
                                network.games.removeAll { $0.id == removedGame.id}
                                if network.games.count == 0 {
                                    network.getGames()
                                }
                            })
                            .frame(width: self.getCardWidth(geometry, id: game.id), height: geometry.size.height)
                            //                            .offset(x: 0, y: self.getCardOffset(geometry, id: game.id))
                            
                        }


                    }
                }
                .padding(.horizontal, 50)
            }
            .onAppear{
                network.getGames()
            }
        }
    }
}

struct theCard: View {
    
    @State private var translation: CGSize = .zero
    @State private var showGame = false
    @State private var someStuff = ""

    var games: TheGames
    var onRemove: (_ game: TheGames) -> Void
    var thresholdPrecentage: CGFloat = 0.5
    
    
    init(games: TheGames, onRemove: @escaping(_ games: TheGames) -> Void) {
        self.games = games
        self.onRemove = onRemove
    }
    private func getGesturePercentage(_ geometry: GeometryProxy, from gesture: DragGesture.Value) -> CGFloat {
        gesture.translation.width / geometry.size.width
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                
                AsyncImage(url: URL(string: "https://images.igdb.com/igdb/image/upload/t_cover_big/\(games.cover?.image_id ?? "N/A").jpg")) { image in
                    image
                        .resizable()
                        .frame(width: 330, height: 320)
                } placeholder: {
                    Image("gameFinder")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 330, height: 330)
                }
                cardText
            }
            .frame(width: 300, height: 500)
            .background(Colors().backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 8)
            
            .offset(x: self.translation.width, y: self.translation.height)
            .rotationEffect(.degrees(Double(self.translation.width / geometry.size.width) * 10), anchor: .bottom)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        self.translation = value.translation
                    } .onEnded { value in
                        if abs(self.getGesturePercentage(geometry, from: value)) > self.thresholdPrecentage {
                            self.onRemove(self.games)
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
                GameView(game: games)
            }
        }
        
    }
    var cardText: some View {

        HStack {
            VStack(alignment: .leading) {
                HStack(alignment: .bottom) {
                    Text(games.name)
                        .lineLimit(2)
                        .font(.title2.bold())
                        .foregroundColor(.white)
                }
                .padding(.bottom, 1)
                VStack(alignment: .leading, spacing: 1.0) {
                    
                    HStack {
                        ForEach((games.platforms?.prefix(4))!) { platform in
                            if platform.name == "PC (Microsoft Windows)" {
                                Text("PC")
                                    .scaledToFit()
                                    .lineLimit(1)
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                
                            } else {
                                Text(platform.name)
                                    .scaledToFit()
                                    .lineLimit(1)
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                               
                            }
                            
                        }
                       
                    }
                    
                    HStack {
                        ForEach((games.genres?.prefix(2))!) { genre in
                            Text(genre.name)
                                    .lineLimit(1)
                                    .font(.subheadline.bold())
                                    .foregroundColor(.white)
                                    .padding(3)
                                    .background(.blue)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                        }
                    }
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
    
}


struct GameCardView_Previews: PreviewProvider {
    static var previews: some View {
        GameCardView()
    }
}

/*
 //TODO:
 
 */
