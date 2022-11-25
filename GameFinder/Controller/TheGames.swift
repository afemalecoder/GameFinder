//
//  Games.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 20/11/2022.
//

import Foundation

struct TheGames: Codable, Identifiable {
    
    struct Screenshots: Codable, Identifiable {
        let id: Int
        let image_id: String
    }
    
    struct Genre: Codable, Identifiable {
        let id: Int
        let name: String
    }
    
    struct Platform: Codable, Identifiable {
        let id: Int
        let name: String
    }
    
    struct Cover: Codable, Identifiable {
        let id: Int
        let game: Int
        let height: Int
        let image_id: String
        let url: String
        let width: Int
//        let checknum: String
    }
    
    var id: Int
    var name: String
    var summary: String?
    var genres: [Genre]?
    var platforms: [Platform]?
    var cover: Cover?
    var screenshots: [Screenshots]?
    
}
