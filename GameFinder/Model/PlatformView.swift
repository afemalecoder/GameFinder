//
//  PlatformVIew.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 28/11/2022.
//

import SwiftUI


struct PlatformView: View {
    @State var currentGame : TheGame
    @State var amount = 9999

  
    var body: some View {
        HStack {
            ForEach((currentGame.platforms?.prefix(amount))!) { platform in
//                AsyncImage(url: URL(string: "https://images.igdb.com/igdb/image/upload/t_thumb/.jpg")) { image in
//                    image
//                        .resizable()
//                        .frame(width: 50, height: 50)
//                } placeholder: {
//                    Image("gameFinder")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 00, height: 00)
//                }
                if platform.name == "PC (Microsoft Windows)" {
                    Label("PC ", systemImage: "desktopcomputer")
                        .scaledToFit()
                        .lineLimit(1)
                        .font(.subheadline)
                        .foregroundColor(.white)
                }  else {
                    Text(platform.name)
                        .scaledToFit()
                        .lineLimit(1)
                        .font(.subheadline)
                        .foregroundColor(.white)
                   
                }
                
            }
           
        }
    }
}

//struct PlatformVIew_Previews: PreviewProvider {
//    static var previews: some View {
//        PlatformView()
//    }
//}
