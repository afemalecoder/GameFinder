//
//  SplashScreenView.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 01/11/2022.
//

import SwiftUI


struct SplashScreenView: View {
    @EnvironmentObject var network: Network

    
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        
        if isActive {
            GamesFinderView()
        } else {
            ZStack{
                Colors().backgroundColor
                VStack {
                    Image("gamesfinder")
                        .resizable()
                        .scaledToFit()
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear{
                    withAnimation(.easeIn(duration: 1.2)){
                        self.size = 1.5
                        self.opacity = 1.0
                    }
                }
            }
            .ignoresSafeArea()
            .onAppear{
                network.getAccessToken()

                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                    withAnimation{
                        self.isActive = true 
                    }
                }
            }
        }
    }
}
