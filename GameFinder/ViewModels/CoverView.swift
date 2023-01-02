//
//  CoverView.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 28/11/2022.
//

import SwiftUI

struct CoverView: View {
    @State var currentGame : TheGame
    @State var coverSizeWidth = CGFloat(100)
    @State var coverSizeHeight = CGFloat(100)
    var body: some View {
        AsyncImage(url: URL(string: "https://images.igdb.com/igdb/image/upload/t_cover_big/\(currentGame.cover?.image_id ?? "N/A").jpg")) { image in
            image
                .resizable()
                .frame(maxWidth: coverSizeWidth, maxHeight: coverSizeHeight)
              
        } placeholder: {
            ProgressView()
                .frame(maxWidth: coverSizeWidth, maxHeight: coverSizeHeight)
        }
        
    }
}
