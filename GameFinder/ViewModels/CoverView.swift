//
//  CoverView.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 28/11/2022.
//

import SwiftUI

struct CoverView: View {
    @State var currentGame : TheGame
    @State var coverSize = CGFloat(100)
    var body: some View {
        AsyncImage(url: URL(string: "https://images.igdb.com/igdb/image/upload/t_cover_big/\(currentGame.cover?.image_id ?? "N/A").jpg")) { image in
            image
                .resizable()
                .frame(width: coverSize, height: coverSize)
        } placeholder: {
            Image("gamefinder")
                .resizable()
                .scaledToFit()
                .frame(width: coverSize, height: coverSize)
        }
        
    }
}

//struct CoverView_Previews: PreviewProvider {
//    static var previews: some View {
//        CoverView()
//    }
//}
