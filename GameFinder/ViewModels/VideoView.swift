//
//  VideoView.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 29/11/2022.
//

import SwiftUI
import WebKit


struct VideoViews: View {
    @State var currentGame : TheGame
    
    var body: some View {
            ScrollView(.horizontal){
                HStack {
                    ForEach(currentGame.videos ?? [TheGame.Video]()) { video in
                        if video.name == "Trailer"{
                            VideoView(videoID: video.video_id)
                                .frame(width: 200, height: 150)
                                .cornerRadius(12)
                        } else {
                            VideoView(videoID: video.video_id)
                                .frame(width: 200, height: 150)
                                .cornerRadius(12)
                        
                    }
                }
            }
//                .padding([.top, .bottom], 15)
        }
    }
}
struct VideoView: UIViewRepresentable {
    
    let videoID: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
       
            
            guard let youtubeURL = URL(string: "https://www.youtube.com/embed/\(videoID)") else {return}
            uiView.scrollView.isScrollEnabled = false
        DispatchQueue.main.async {
            uiView.load(URLRequest(url: youtubeURL))
            
        }
    }
}
