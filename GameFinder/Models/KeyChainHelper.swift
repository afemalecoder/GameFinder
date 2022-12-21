//
//  KeyChainHelper.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 19/12/2022.
//

import Foundation

final class KeychainHelper {
    
    enum TokenType: String {
        case access = "access-token"
        case refresh = "refresh-token"
    }
    
    static let standard = KeychainHelper()
    private init() {}
    
    static func saveToken(_ token: String, type: TokenType) {
        let data = Data(token.utf8)
        self.saveToKeychain(data, service: type.rawValue, account: "IGDB")
    }
    
    static func readToken(_ type: TokenType) -> String? {
        guard let tokenData = self.readKeychain(service: type.rawValue, account: "IGDB") else {
            print("Error tokenData")
            return nil
        }
        guard let accessToken = String(data: tokenData, encoding: .utf8) else {
            print("Error accessToken")
            return nil
        }
        return accessToken
    }
    
    static private func saveToKeychain(_ data: Data, service: String, account: String) {
        
        // Create query
        let query = [
            kSecValueData: data,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
        ] as CFDictionary
        
        // Add data in query to keychain
        let status = SecItemAdd(query, nil)
        
        if status != errSecSuccess {
            // Print out the error
            print("Error: \(status)")
           
        }
        if status == errSecDuplicateItem {
             // Item already exist, thus update it.
             let query = [
                 kSecAttrService: service,
                 kSecAttrAccount: account,
                 kSecClass: kSecClassGenericPassword,
             ] as CFDictionary

             let attributesToUpdate = [kSecValueData: data] as CFDictionary

             // Update existing item
             SecItemUpdate(query, attributesToUpdate)
         }
      
    }
    
   static private func readKeychain(service: String, account: String) -> Data? {
        
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as CFDictionary
        
        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        
        return (result as? Data)
    }
}
