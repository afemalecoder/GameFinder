//
//  Games.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 20/11/2022.
//

import Foundation

struct TheGame: Codable, Identifiable {
    
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
        let image_id: String
    }
    
    struct Date: Codable, Identifiable {
        let id: Int
        let m: Int
        let y: Int
    }
    struct Companies: Codable, Identifiable{
        let id: Int
        let company : Company
    }

    struct Company: Codable, Identifiable{
        let id: Int
        let name: String
    }

    var id: Int
    var aggregated_rating: Double?
    var name: String
    var summary: String?
    var genres: [Genre]?
    var platforms: [Platform]?
    var cover: Cover?
    var screenshots: [Screenshots]?
    var release_dates: [Date]?
    var involved_companies: [Companies]?
}
