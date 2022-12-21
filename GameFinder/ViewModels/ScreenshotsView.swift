//
//  ScreenshotsView.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 13/12/2022.
//

import SwiftUI

struct ScreenshotsView: View {
    @State var currentGame : TheGame
    @State var isImageTapped = false
    
    var body: some View {
        NavigationStack {
            HStack {
                ForEach(currentGame.screenshots ?? [TheGame.Screenshots]()) { screenshot in
                    AsyncImage(url: URL(string: "https://images.igdb.com/igdb/image/upload/t_screenshot_big/\(screenshot.image_id).jpg")) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 80)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    } placeholder: {
                        Image("gameFinder")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 90)
                            .clipShape(RoundedRectangle(cornerRadius: 20))

                    }
                }
            } .onTapGesture{
                isImageTapped.toggle()
            }
            .sheet(isPresented: $isImageTapped) {
                ImageSliderView(imageURL: currentGame)
                    .presentationDetents([.fraction(0.75)])
            }
//            NavigationLink("", destination: ImageSliderView(imageURL: currentGame), isActive: $isImageTapped)
        }
    }
}
