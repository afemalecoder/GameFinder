//
//  Games.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 20/11/2022.
//

import Foundation

struct Games: Identifiable, Decodable {
    
    struct Genre: Decodable {
        let name: String
    }
    
    var id: Int
    var name: String
    var summary: String?
    var genres: [Genre]?

}
