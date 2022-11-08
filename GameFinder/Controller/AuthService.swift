//
//  LoginLogic.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 03/11/2022.
//

import SwiftUI
import Firebase

class AuthService: ObservableObject {
    
    @Published var errorMessage =  ""
    @Published var registerd = false
    @Published var loggedIn = false
    
    func loginUser(userEmail: String, userPassword: String){
        Auth.auth().signIn(withEmail: userEmail, password: userPassword) { authResult, error in
            if(error != nil){
                print("Error")
                self.errorMessage = error?.localizedDescription ?? ""
                self.loggedIn = false
            } else {
                self.loggedIn = true
            }
        }
    }
    
    func registerUser(userEmail: String, userPassword: String){
        Auth.auth().createUser(withEmail: userEmail, password: userPassword) { authResult, error in
            if(error != nil){
                self.errorMessage = error?.localizedDescription ?? ""
                print("\(self.errorMessage)")
                self.registerd = false
            } else {
                self.errorMessage = ""
                self.registerd = true
            }
        }
    }
}
