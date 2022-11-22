//
//  GameCardView.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 21/11/2022.
//

import SwiftUI

struct GameCardView: View {
    @EnvironmentObject var network: Network
    @State private var title: String = "Witcher 3: the wild hunt"
    @State private var platforms: String = "PS, PC, Xbox"
    @State private var genres: String = "RPG"
    @State private var summary: String = "This is the best game ever. That's all you need to know about this game. If you havent played it you really should!!"
    
    var body: some View {
        ZStack() {
            LinearGradient(gradient: Gradient(colors: [Colors().backgroundColor,Colors().secondaryBackgroundColor ]), startPoint: .top, endPoint: .bottom)
            VStack(alignment: .center) {
                Image("witcher3")
                    .resizable()
                    .frame(width: 330, height: 320)
                cardText.padding(10)
            }
            .background(Colors().backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 8)
            .padding(.horizontal, 50)
        }
        .ignoresSafeArea()
    }
    
    var cardText: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .bottom) {
                Text(title)
                    .font(.title.bold())
                    .foregroundColor(.white)
            }
            .padding(.bottom, 5)
            VStack(alignment: .leading, spacing: 4.0) {
                Text(platforms)
                    .foregroundColor(.white)
                Text(genres)
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width: .infinity, height: .infinity)
                    .padding(5)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text(summary)
                    .font(.headline)
                    .foregroundColor(.white)
            }
            .padding(.bottom, 20)
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
