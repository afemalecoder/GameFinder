//
//  GameFinderView.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 03/11/2022.
//

import SwiftUI

struct GameFinderView: View {
    var body: some View {
        NavigationStack{
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Colors().backgroundColor,Colors().secondaryBackgroundColor ]), startPoint: .top, endPoint: .bottom)
            }
            .ignoresSafeArea()
        }
    }
}

struct GameFinderView_Previews: PreviewProvider {
    static var previews: some View {
        GameFinderView()
    }
}
