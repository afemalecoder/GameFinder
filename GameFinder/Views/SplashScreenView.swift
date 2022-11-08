//
//  SplashScreenView.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 01/11/2022.
//

import SwiftUI
import Firebase

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    var user = Auth.auth().currentUser
    
    var body: some View {
        if isActive {
            if user != nil{
                GameFinderView()
            } else{
                ContentView()
            }
        } else {
            ZStack{
                Color(red: 18 / 255, green: 21 / 255, blue: 64 / 255)
                VStack {
                    Image("gameFinder")
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
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                    withAnimation{
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
