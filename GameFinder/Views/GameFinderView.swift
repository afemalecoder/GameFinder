//
//  GameFinderView.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 03/11/2022.
//

import SwiftUI

struct GameFinderView: View {
    @State private var joke: String = ""
    
    var body: some View {
        NavigationStack{
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Colors().backgroundColor,Colors().secondaryBackgroundColor ]), startPoint: .top, endPoint: .bottom)
                VStack {
                    Text(joke)
                    Button {
                        Task {
                            let (data, _) = try await URLSession.shared.data(from: URL(string: "https://api.chucknorris.io/jokes/random")!)
                            let decodedResponse = try? JSONDecoder().decode(Joke.self, from: data)
                            joke = decodedResponse?.value ?? "Didn't work"
                        }
                    } label: {
                        Text("Fetch joke")
                    }
                }
            }
            .ignoresSafeArea()
        }
    }
    struct Joke: Codable {
        let value: String
    }
}

struct GameFinderView_Previews: PreviewProvider {
    static var previews: some View {
        GameFinderView()
    }
}
