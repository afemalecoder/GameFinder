//
//  SteamRatingPriceView.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 14/12/2022.
//

import SwiftUI

struct SteamRatingPriceView: View {
    @State var games : [Steam]
    @Environment(\.openURL) var openURL
    
    var body: some View {
        ForEach(games) { game in
            HStack(spacing: 15) {
                VStack {
                    Text("Normal price:")
                        .font(.title3.bold())
                    Text("$\(game.normalPrice)")
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 5)
                .padding(.vertical, 20)
                .background(Color(red: 55 / 255, green: 55 / 255, blue: 128 / 255))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .onTapGesture {
                    openURL(URL(string: "http://store.steampowered.com/app/\(game.steamAppID ?? "")")!)
                }
                
                VStack {
                    Text("Sale prices: ")
                        .font(.title3.bold())
                    if game.salePrice == game.normalPrice {
                        Text("N/A")
                    } else {
                        Text("$\(game.salePrice)")
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 5)
                .padding(.vertical, 20)
                .background(Color(red: 55 / 255, green: 55 / 255, blue: 128 / 255))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .onTapGesture {
                    openURL(URL(string: "http://store.steampowered.com/app/\(game.steamAppID ?? "")")!)
                }
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
            .onTapGesture {
                openURL(URL(string: "http://store.steampowered.com/app/\(game.steamAppID ?? "")")!)
            }
        }
        .padding(.bottom, 15)
    }
}
