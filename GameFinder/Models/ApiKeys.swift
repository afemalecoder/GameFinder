//
//  ApiKeys.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 21/12/2022.
//

import Foundation

struct ApiKeys {
    
        enum GetApiKeys: String {
            case clientID = "CLIENT_ID"
            case clientSecret = "CLIENT_SECRET"
        }
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("plist file not found")
        }
        return dict
    }()
    
    static let clientID: String = {
        guard let getClientIDString = infoDictionary[GetApiKeys.clientID.rawValue] as? String else {
            fatalError("ClientID not set in plist")
        }
               return getClientIDString
    }()

    
    static let clientSecret: String = {
        guard let getClientSecretString = infoDictionary[GetApiKeys.clientSecret.rawValue] as? String else {
            fatalError("ClientSecret not set in plist")
        }
        return getClientSecretString
    }()
}
