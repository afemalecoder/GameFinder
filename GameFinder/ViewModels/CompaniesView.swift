//
//  CompaniesView.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 13/12/2022.
//

import SwiftUI

struct CompaniesView: View {
    @State var currentGame : TheGame
    var developers = [""]
    var publisher = [""]
    
    var body: some View {
        if currentGame.involved_companies != nil {
            VStack(alignment: .center) {
                HStack(alignment: .center) {
                    Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: 2)
                        .foregroundColor(.white)
                        .opacity(0.5)
                        .shadow(radius: 2)
                        .padding(.vertical, 20)
                    Text("Team")
                    Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: 2)
                        .foregroundColor(.white)
                        .opacity(0.5)
                        .shadow(radius: 2)
                        .padding(.vertical, 20)
                }
                HStack {
                    ForEach(currentGame.involved_companies ?? [TheGame.Companies]()) { company in
                        if company.developer != false {
                            VStack {
                                Text("Developer: ")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                                Text(company.company.name)
                            }
                            .padding(.horizontal, 20)
                        } else if company.publisher != false {
                            VStack {
                                Text("Publisher: ")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                                Text(company.company.name)
                            }
                        }
                    }
                }
            }
        }
    }
}
