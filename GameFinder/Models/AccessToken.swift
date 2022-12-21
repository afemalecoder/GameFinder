//
//  accessToken.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 16/12/2022.
//

import Foundation

struct AccessToken: Codable {
    var access_token: String
    var expires_in: Int
    var token_type: String 
}
