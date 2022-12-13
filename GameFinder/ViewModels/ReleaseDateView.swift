//
//  ReleaseDateView.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 13/12/2022.
//

import SwiftUI

struct ReleaseDateView: View {
    @State var currentGame : TheGame
    let dateFormatter = Date()
    
    var body: some View {
        if currentGame.first_release_date ?? 0 != 0 {
            HStack(alignment: .bottom) {
                Text("Release date:")
                Text("\(NSDate(timeIntervalSince1970: Double(currentGame.first_release_date ?? 0)) as Date.FormatStyle.FormatInput, format: Date.FormatStyle().year().month().day())")
                    .font(.system(size: 22))
            }
        } else {
            Text("Release date: N/A")
        }
    }
}
