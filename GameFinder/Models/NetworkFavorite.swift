//
//  NetworkFavorite.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 08/12/2022.
//

import Foundation
import SwiftUI

class NetworkFavorite: ObservableObject {
    @EnvironmentObject var network: Network
    @Published var games = [TheGame]()
    var clientID = ApiKeys.GetApiKeys.clientID.rawValue

    func getFavoriteGames(favGameID: Int, completion: @escaping () -> ()) {
        if KeychainHelper.readToken(.access) == nil {
            network.getAccessToken()
        } else {
            guard let url = URL(string: "https://api.igdb.com/v4/games/") else { fatalError("Missing URL") }
            
            var requestHeader = URLRequest(url: url)
            requestHeader.httpBody = "fields themes.*,game_modes.*,slug,multiplayer_modes.*,name,platforms.name,genres.name,involved_companies.company.name, involved_companies.*,aggregated_rating,first_release_date,summary,screenshots.*,cover.*,player_perspectives.name,videos.*,websites.*;limit 50;where cover!=null&id=(\(favGameID));".data(using: .utf8, allowLossyConversion: false)
            requestHeader.httpMethod = "POST"
            requestHeader.setValue("\(clientID)", forHTTPHeaderField: "Client-ID")
            requestHeader.setValue("Bearer \(KeychainHelper.readToken(.access)!)", forHTTPHeaderField: "Authorization")
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
                            completion()
                        } catch let error {
                            print("Error decoding:", error)
                        }
                    }
                }
            }
            dataTask.resume()
        }
    }
}
