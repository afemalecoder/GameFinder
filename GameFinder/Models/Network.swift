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
    var randomNumber: [Int] = []
    var randoms = ""
    var clientID = ApiKeys.clientID
    var clientSecret = ApiKeys.clientSecret
    
    func getAccessToken() {
            guard let accessTokenURL = URL(string:"https://id.twitch.tv/oauth2/token?client_id=\(clientID)&client_secret=\(clientSecret)&grant_type=client_credentials") else {fatalError("Missing URL")}
            
            var requestHeader = URLRequest(url: accessTokenURL)
            requestHeader.httpMethod = "POST"
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
                            let decodedAccessToken = try JSONDecoder().decode(AccessToken.self, from: data)
                            
                            KeychainHelper.saveToken(decodedAccessToken.access_token, type: .access)
                        } catch let error {
                            print("Error decoding:", error)
                            
                        }
                    }
                }
            }
            dataTask.resume()
    }
    
    func getGames(completion: @escaping () -> ()) {
        if KeychainHelper.readToken(.access) == nil {
            getAccessToken()
        } else {
            for _ in 1...100 {
                randomNumber.append(Int.random(in: 1..<212144))
                let randomString = randomNumber.map(String.init)
                randoms = randomString.joined(separator: ",")
            }
            if randomNumber.count >= 100 {
                randomNumber = [0]
            }
            
            guard let url = URL(string: "https://api.igdb.com/v4/games/") else { fatalError("Missing URL") }
            
            var requestHeader = URLRequest(url: url)
            requestHeader.httpBody = "fields themes.*,game_modes.*,slug,multiplayer_modes.*,name,platforms.name,genres.name,involved_companies.company.name, involved_companies.*,aggregated_rating,first_release_date,summary,screenshots.*,cover.*,player_perspectives.name,videos.*,websites.*;limit 100;where cover!=null&id=(\(randoms))&themes!=(42);".data(using: .utf8, allowLossyConversion: false)
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
