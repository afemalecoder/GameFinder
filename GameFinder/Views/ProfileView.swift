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
                VStack(){
                    Text("My Profile")
                        .modifier(Style.Titles())
                    Image("gameFinder")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                    Text("Matilda Cederberg")
                        .modifier(Style.Titles())
                    Text("email.com")
                        .foregroundColor(.gray)
                    HStack{
                        //icon
                        //name
                        //arrow in form of a button
                    }
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
