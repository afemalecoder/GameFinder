//
//  GameCardView.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 21/11/2022.
//

import SwiftUI

struct Games: Hashable, CustomStringConvertible {
    var id: Int
    let title: String
    let platforms: String
    let genres: String
    let summary: String
   
    var description: String {
        return "\(title), id: \(id)"
    }
}

struct GameCardView: View {
    @EnvironmentObject var network: Network
//    var id: Int
//    let title: String
//    let platforms: String
//    let genres: String
//    let summary: String

    
    @State var games: [Games] =
    [Games(id: 0, title: "Witcher 3: the wild hunt", platforms: "PS, PC, Xbox", genres: "RPG", summary: "This is the best game ever. That's all you need to know about this game. If you havent played it you really should!!"),
     Games(id: 1, title: "Witcher 3: the wild hunt", platforms: "PS, PC, Xbox", genres: "RPG", summary: "This is the best game ever. That's all you need to know about this game. If you havent played it you really should!!"),
     Games(id: 3, title: "Witcher 3: the wild hunt", platforms: "PS, PC, Xbox", genres: "RPG", summary: "This is the best game ever. That's all you need to know about this game. If you havent played it you really should!!"),
     Games(id: 4, title: "Witcher 3: the wild hunt", platforms: "PS, PC, Xbox", genres: "RPG", summary: "This is the best game ever. That's all you need to know about this game. If you havent played it you really should!!"),
     Games(id: 5, title: "Witcher 3: the wild hunt", platforms: "PS, PC, Xbox", genres: "RPG", summary: "This is the best game ever. That's all you need to know about this game. If you havent played it you really should!!"),]
    
    private func getCardWidth(_ geometry: GeometryProxy, id: Int) -> CGFloat {
        let offset: CGFloat = CGFloat(games.count - 1 - id) * 10
        return geometry.size.width - offset
    }
    private func getCardOffset(_ geometry: GeometryProxy, id: Int) -> CGFloat {
        return  CGFloat(games.count - 1 - id) * 5
    }
    private var maxID: Int {
        return self.games.map { $0.id }.max() ?? 0
    }
    
    var body: some View {
        NavigationStack {
            VStack() {
                GeometryReader { geometry in
                    ZStack {
                        ForEach(self.games, id: \.self) { game in
                            if game.id > self.maxID - 4 {
                                theCard(games: game, onRemove: { removedGame in
                                    self.games.removeAll { $0.id == removedGame.id}
                                })
                                .frame(width: self.getCardWidth(geometry, id: game.id), height: geometry.size.height)
                                .offset(x: 0, y:self.getCardOffset(geometry, id: game.id))
                            }
                        }
                    }
                }
                .padding(.horizontal, 40)
            }
        }
    }
}

struct theCard: View {
    
    @State private var translation: CGSize = .zero
    
    var games: Games
    var onRemove: (_ game: Games) -> Void
    var thresholdPrecentage: CGFloat = 0.5
    
    init(games: Games, onRemove: @escaping(_ games: Games) -> Void) {
        self.games = games
        self.onRemove = onRemove
    }
    private func getGesturePercentage(_ geometry: GeometryProxy, from gesture: DragGesture.Value) -> CGFloat {
        gesture.translation.width / geometry.size.width
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                Image("witcher3")
                    .resizable()
                    .frame(width: 300, height: 300)
                cardText
            }
            .frame(width: 300, height: 500)
            .background(Colors().backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 8)
            .offset(x: self.translation.width, y: self.translation.height)
            .rotationEffect(.degrees(Double(self.translation.width / geometry.size.width) * 25), anchor: .bottom)
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
        }
        
    }
    var cardText: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack(alignment: .bottom) {
                    Text(self.games.title)
                        .font(.title2.bold())
                        .foregroundColor(.white)
                }
                .padding(.bottom, 2)
                VStack(alignment: .leading, spacing: 4.0) {
                    Text(self.games.platforms)
                        .font(.subheadline)
                        .foregroundColor(.white)
                    Text(self.games.genres)
                        .font(.subheadline.bold())
                        .foregroundColor(.white)
                        .padding(3)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                    Text(self.games.summary)
                        .font(.headline)
                        .foregroundColor(.white)
                    Spacer()
                }
            }
            .padding(.horizontal, 10)
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
 - Image fills the whole card (big part of the screen)
 - Rounded corners
 - Opaque container 1/3 of the bottom part image storing details
 - Details: Game title (Header text), Genres (text in a small oval container, platforms (text in small oval container), Summary (text).
 - Check if you can add the card and image to the background card.
 */
