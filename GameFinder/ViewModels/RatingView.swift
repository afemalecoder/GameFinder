//
//  RatingView.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 13/12/2022.
//

import SwiftUI

struct RatingView: View {
    @State var currentGame : TheGame
    
    var body: some View {
        if currentGame.aggregated_rating ?? 0.0 != 0.0 {
            Text("\((currentGame.aggregated_rating ?? 0.0),specifier: "%.2f")")
                .font(.subheadline.bold())
                .padding(15)
                .foregroundColor(.white)
                .background(Color(red: 106 / 255, green: 103 / 255, blue: 244 / 255))
                .clipShape(Circle())
        }
    }
}
