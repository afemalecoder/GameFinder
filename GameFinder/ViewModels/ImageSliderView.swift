//
//  ImageSliderView.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 12/12/2022.
//

import SwiftUI

struct ImageSliderView: View {
    let imageURL: TheGame
    private let timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()
    @State private var currentIndex = 0
    
    var body: some View {
        VStack {
            Rectangle()
                .frame( width: 60, height: 3)
                .foregroundColor(.white)
                .opacity(0.5)
                .shadow(radius: 2)
                .padding(.vertical, 20)
               
            TabView(selection: $currentIndex) {
                ForEach(imageURL.screenshots ?? [TheGame.Screenshots]()) { screenshot in
                    AsyncImage(url: URL(string: "https://images.igdb.com/igdb/image/upload/t_screenshot_big/\(screenshot.image_id).jpg")) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 450, height: 400)
                            .cornerRadius(12)
                    } placeholder: {
                        Image("gamefinder")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                            .cornerRadius(12)
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
        .background(Colors().backgroundColor)

    }
}
