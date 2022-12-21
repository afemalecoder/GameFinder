//
//  Steam.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 30/11/2022.
//

import Foundation

struct Steam: Codable, Identifiable {
    let id : Int?
    var title: String
    var normalPrice: String
    var salePrice: String
    var steamRatingPercent: String
    var thumb: String
    var steamRatingText: String?
    var steamRatingCount: String
    var steamAppID: String?
}

class Api: ObservableObject {
    @Published var steamGames = [Steam]()
    
    func loadData(url: String, completion: @escaping ([Steam]) -> ()) {
        guard let url = URL(string: url) else {
            print("The url was invalid")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {return}
            
            if response.statusCode == 200 {
                guard let data = data else {return}
                
                DispatchQueue.main.async {
                    do {
                        let  steams = try JSONDecoder().decode([Steam].self, from: data)
                        
                        completion(steams)
                    } catch let error {
                        print("Error decoding: \(error)")
                    }
                }
            }
        }
        .resume()
    }
}
