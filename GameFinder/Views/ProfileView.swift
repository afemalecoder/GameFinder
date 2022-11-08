//
//  ProfileView.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 08/11/2022.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationStack{
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Colors().backgroundColor,Colors().secondaryBackgroundColor ]), startPoint: .top, endPoint: .bottom)
                VStack(alignment: .leading){
                    Text("My Profile")
                        .modifier(Style.Titles())
                    Image("gameFinder")
                        .resizable()
                        .scaledToFit()
                }
            }
            .ignoresSafeArea()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
