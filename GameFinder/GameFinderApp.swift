//
//  GameFinderApp.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 01/11/2022.
//

import SwiftUI


//
//class AppDelegate: NSObject, UIApplicationDelegate {
//  func application(_ application: UIApplication,
//                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//    FirebaseApp.configure()
//
//    return true
//  }
//}

@main
struct GameFinderApp: App {
    
    init() {
        
    }
    var network = Network()
    
    
    @StateObject private var dataController = DataController()

//    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
//    @StateObject var authService = AuthService()
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView().environmentObject(network)
                .environment(\.managedObjectContext, dataController.container.viewContext)

        }
    }
}
