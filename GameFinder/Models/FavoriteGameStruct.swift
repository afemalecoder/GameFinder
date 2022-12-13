//
//  FavoriteGameStruct.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 08/12/2022.
//

import Foundation

struct FavoriteGameStruct: Codable, Identifiable {

    
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
    
    struct Companies: Codable, Identifiable{
        let id: Int
        let company : Company
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
    var genres: [Genre]?
    var platforms: [Platform]?
    var screenshots: [Screenshots]?
    var involved_companies: [Companies]?
    var player_perspectives: [Perspective]?
    var videos: [Video]?
    var multiplayer_modes: [Multiplayer]?
    var game_modes: [Modes]?
    var themes: [Themes]?
}
