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
            ForEach((currentGame.platforms?.prefix(amount) ?? [TheGame.Platform]().prefix(amount))) { platform in
                if platform.name == "PC (Microsoft Windows)" {
                    Text("PC ")
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
