//
//  Network.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 20/11/2022.
//

import Foundation
import SwiftUI

class Network: ObservableObject {
    @Published var games = [Games]()

    
    func getGames() {
        guard let url = URL(string: "https://api.igdb.com/v4/games/") else {fatalError("Missing URL")}
        
        var requestHeader = URLRequest(url: url)
        requestHeader.httpBody = "fields name,platforms.name,genres.name,summary,cover.*;".data(using: .utf8, allowLossyConversion: false)
        requestHeader.httpMethod = "POST"
        requestHeader.setValue("t6nopay939jxpnppaovtm5v8x02b9y", forHTTPHeaderField: "Client-ID")
        requestHeader.setValue("Bearer vrq1iq9enmbuuk217xyeelqmpy2dhl", forHTTPHeaderField: "Authorization")
        requestHeader.setValue("application/json", forHTTPHeaderField: "Accept")
        
       let dataTask = URLSession.shared.dataTask(with: requestHeader) {(data, response, error) in
           if let error = error {
               print("Request error:", error)
               return
           }
           guard let response = response as? HTTPURLResponse else {return}
           
           if response.statusCode == 200 {
               guard let data = data else {return}
               DispatchQueue.main.async {
                   do {
                       let decodedGames = try JSONDecoder().decode([Games].self, from: data)
                       
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

