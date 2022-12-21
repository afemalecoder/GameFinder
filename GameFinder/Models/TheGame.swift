//
//  Games.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 20/11/2022.
//

import Foundation


struct TheGame: Codable, Identifiable {
    
//    enum CodingKeys: String, CodingKey {
//        case firstReleaseDate = "first_release_date"
//        case involvedCompanies = "involved_companies"
//        case playerPerspectives = "player_perspectives"
//        case multiplayerModes = "multiplayer_modes"
//        case gameModes = "game_modes"
//    }
    
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
        //        let image_id: String
    }
    
    struct Cover: Codable, Identifiable {
        let id: Int
        let image_id: String
    }
    
    struct Companies: Codable, Identifiable{
        let id: Int
        let company : Company
        let developer : Bool
        let publisher : Bool
    }
    
    struct Company: Codable, Identifiable{
        let id: Int
        let name: String
    }
    struct Perspective: Codable, Identifiable{
        let id: Int
        let name: String
    }
    struct Video: Codable, Identifiable {
        let id: Int
        let name: String?
        let video_id: String
    }
    struct Website: Codable, Identifiable {
        let id: Int
        let category: Int
        let url: String
    }
    struct Multiplayer: Codable, Identifiable {
        var id: Int
        var campaigncoop: Bool
        var lancoop: Bool
        var offlinecoop: Bool
        var offlinecoopmax: Int?
        var offlinemax: Int?
        var onlinecoop: Bool
        var onlinecoopmax: Int?
        var onlinemax: Int?
        var splitscreen: Bool
    }
    
    struct Modes: Codable, Identifiable {
        var id: Int
        var name: String
    }
    
    struct Themes: Codable, Identifiable {
        var id: Int
        var name: String 
    }

    var id: Int
    var slug: String?
    var aggregated_rating: Double?
    var name: String?
    var summary: String?
    var genres: [Genre]?
    var platforms: [Platform]?
    var cover: Cover?
    var screenshots: [Screenshots]?
    var first_release_date: Int?
    var involved_companies: [Companies]?
    var player_perspectives: [Perspective]?
    var videos: [Video]?
    var websites: [Website]?
    var multiplayer_modes: [Multiplayer]?
    var game_modes: [Modes]?
    var themes: [Themes]?
    
}
