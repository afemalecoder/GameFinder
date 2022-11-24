//
//  GameFinderView.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 03/11/2022.
//

import SwiftUI

struct GameFinderView: View {
    @EnvironmentObject var network: Network
    
    var body: some View {
        NavigationStack{
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Colors().backgroundColor,Colors().secondaryBackgroundColor ]), startPoint: .top, endPoint: .bottom)
                VStack(){
                    GameCardView()
                }
                .padding(.top, 150)
//                ScrollView {
//                    ForEach(network.games) { game in
//                        VStack(alignment: .center) {
//
//                            AsyncImage(url: URL(string: "https:\(game.cover?.url ?? "N/A")")) { image in
//                                image
//                                    .resizable()
//                                    .frame(width: 330, height: 320)
//                            } placeholder: {
//                                Color.blue
//                            }
//                            .frame(width: 330, height: 330)
//
//                            HStack(alignment: .bottom) {
//                                Text(game.name)
//                                    .font(.title.bold())
//                                    .foregroundColor(.white)
//                            }
//                            .padding(.bottom, 5)
//                            VStack(alignment: .leading, spacing: 4.0) {
//
//                                ForEach(game.platforms ?? [TheGames.Platform]()) { platform in
//                                    Text("\(platform.name)")
//                                        .foregroundColor(.white)
//                                }
////                                ForEach(game.genres) { genre in
////                                    Text("\(genre.name)")
////                                        .font(.title2)
////                                        .foregroundColor(.white)
////                                        .frame(width: .infinity, height: .infinity)
////                                        .padding(5)
////                                        .background(.blue)
////                                        .clipShape(RoundedRectangle(cornerRadius: 10))
////                                }
//                                Text(game.summary ?? "")
//                                    .font(.headline)
//                                    .foregroundColor(.white)
//                            }
//                            .padding(10)
//                        }
//                    }
//                }
//                .background(Colors().backgroundColor)
//                .clipShape(RoundedRectangle(cornerRadius: 20))
//                .shadow(radius: 8)
//                .padding(.horizontal, 50)
            }
            .ignoresSafeArea()
        }
        .onAppear{
            network.getGames()
        }
    }
}

struct GameFinderView_Previews: PreviewProvider {
    static var previews: some View {
        GameFinderView().environmentObject(Network())
    }
}
