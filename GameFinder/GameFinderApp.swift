//
//  GameFinderApp.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 01/11/2022.
//

import SwiftUI
import Firebase


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct GameFinderApp: App {
    var network = Network()
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var authService = AuthService()
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView().environmentObject(network)
//            GameFinderView().environmentObject(network)
//            GameCardView().environmentObject(network)
            
        }
    }
}
