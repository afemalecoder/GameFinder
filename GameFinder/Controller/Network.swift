//
//  Network.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 20/11/2022.
//

import Foundation
import SwiftUI

class Network: ObservableObject {
    @Published var games = [TheGames]()

    
    func getGames() {
        guard let url = URL(string: "https://api.igdb.com/v4/games/") else { fatalError("Missing URL") }
        
        var requestHeader = URLRequest(url: url)
        requestHeader.httpBody = "fields name,platforms.name,genres.name,summary,cover.*;limit 50;where cover!=null&genres.name!=null&platforms.name!=null;".data(using: .utf8, allowLossyConversion: false)
        requestHeader.httpMethod = "POST"
        requestHeader.setValue("t6nopay939jxpnppaovtm5v8x02b9y", forHTTPHeaderField: "Client-ID")
        requestHeader.setValue("Bearer xd1utotladc3j33d6bafo3et5e3mpb", forHTTPHeaderField: "Authorization")
        requestHeader.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let dataTask = URLSession.shared.dataTask(with: requestHeader) { (data, response, error) in
           if let error = error {
               print("Request error:", error)
               return
           }
           
           guard let response = response as? HTTPURLResponse else {return}
           
           if response.statusCode == 200 {
               guard let data = data else {return}
               DispatchQueue.main.async {
                   do {
                       let decodedGames = try JSONDecoder().decode([TheGames].self, from: data)
                       
                       self.games = decodedGames
                       
                   } catch let error {
                       print("Error decoding:", error)
                   }
               }
           }
        }
        dataTask.resume()
    }
}

