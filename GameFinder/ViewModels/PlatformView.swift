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
    
    struct LabelStyle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .lineLimit(1)
                .font(.headline.bold())
                .foregroundColor(.white)
                .padding(5)
                .background(Color(red: 83 / 255, green: 83 / 255, blue: 181 / 255))
                .clipShape(RoundedRectangle(cornerRadius: 5))
        }
    }
    
    var body: some View {
        
        if currentGame.platforms != nil {
            VStack(alignment: .leading, spacing: 0) {
                Text("Platforms: ")
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
                ScrollView(.horizontal) {
                    HStack {
                        ForEach((currentGame.platforms?.prefix(amount) ?? [TheGame.Platform]().prefix(amount))) { platform in
                            switch platform.name  {
                            case "PC (Microsoft Windows)" :
                                Label("PC", image: "pc")
                                    .modifier(LabelStyle())
                            case "Mac" :
                                Label("\(platform.name)", image: "iMac")
                                    .modifier(LabelStyle())
                            case "Android" :
                                Label("\(platform.name)", image: "android")
                                    .modifier(LabelStyle())
                            case "iOS" :
                                Label("\(platform.name)", image:"ios")
                                    .modifier(LabelStyle())
                            case "Linux" :
                                Label("\(platform.name)", image:"linux")
                                    .modifier(LabelStyle())
                            case "Nintendo Switch" :
                                Label("\(platform.name)", image:"nintendo")
                                    .modifier(LabelStyle())
                            case "Xbox One", "Xbox 360", "Xbox Series X|S", "Xbox" :
                                Label("\(platform.name)", image:"xbox")
                                    .modifier(LabelStyle())
                            case "PlayStation", "PlayStation 2", "PlayStation 3", "PlayStation 4", "PlayStation 5", "PlayStation Portable", "PlayStation Vita" :
                                Label("\(platform.name)", image:"playstation")
                                    .modifier(LabelStyle())
                            default:
                                Text(platform.name)
                                    .modifier(LabelStyle())
                            }
                        }
                    }
                }
            }
        } else {
            Text("N/A")
        }
            
    }
}
