//
//  Steam.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 30/11/2022.
//

import Foundation

struct Steam: Codable, Identifiable {
    let id = UUID()
    var title: String
    var normalPrice: String
    var salePrice: String
    var steamRatingPercent: String
    var thumb: String
    var steamRatingText: String?
    var steamRatingCount: String
}

class Api: ObservableObject {
    @Published var steamGames = [Steam]()
    
    func loadData(url: String, completion: @escaping ([Steam]) -> ()) {
        guard let url = URL(string: url) else {
            print("The url was invalid")
            return
        }
        print(url)
        URLSession.shared.dataTask(with: url) { data, response, error in
            let  steams = try! JSONDecoder().decode([Steam].self, from: data!)
            DispatchQueue.main.async {
                completion(steams)
            }
        }.resume()
    }
}
