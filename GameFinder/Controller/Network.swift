//
//  Network.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 20/11/2022.
//

import Foundation
import SwiftUI

class Network: ObservableObject {
    @Published var games = [TheGame]()
//    @Published var steam = [Steam]()
    
    func getGames() {
        guard let url = URL(string: "https://api.igdb.com/v4/games/") else { fatalError("Missing URL") }
        
        var requestHeader = URLRequest(url: url)
        requestHeader.httpBody = "fields slug,name,platforms.name,genres.name,involved_companies.company.name,aggregated_rating,first_release_date,summary,screenshots.*,cover.*,player_perspectives.name,videos.*,websites.*;limit 50;where cover!=null&genres.name!=null&platforms.name!=null&rating>70;".data(using: .utf8, allowLossyConversion: false)
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
                       let decodedGames = try JSONDecoder().decode([TheGame].self, from: data)
                       
                       self.games = decodedGames
                       
                   } catch let error {
                       print("Error decoding:", error)
                   }
               }
           }
        }
        dataTask.resume()
    }
//    func getPrice() {
//
//
//        guard let url = URL(string: "https://www.cheapshark.com/api/1.0/deals?steamRating=0&desc=0&output=json&steamworks=0&sortBy=Deal Rating&AAA=0&pageSize=60&exact=0&upperPrice=50&pageNumber=0&onSale=0&metacritic=0&storeID[0]=1&lowerPrice=0&title=Thief II: The Metal Age") else {fatalError("missing url")}
//
//
//        var requestHeader = URLRequest(url: url)
//        requestHeader.httpMethod = "GET"
//
//        let dataTask = URLSession.shared.dataTask(with: requestHeader) { (data, response, error) in
//           if let error = error {
//               print("Request error:", error)
//               return
//           }
//
//           guard let response = response as? HTTPURLResponse else {return}
//
//           if response.statusCode == 200 {
//               guard let data = data else {return}
//               DispatchQueue.main.async {
//                   do {
//                       let decodedGames = try JSONDecoder().decode([Steam].self, from: data)
//
//                       self.steam = decodedGames
//
//                   } catch let error {
//                       print("Error decoding:", error)
//                   }
//               }
//           }
//        }
//        dataTask.resume()
//    }
}

