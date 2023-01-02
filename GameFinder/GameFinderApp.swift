//
//  GameFinderApp.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 01/11/2022.
//

import SwiftUI

@main
struct GameFinderApp: App {
    
    init() {
        
    }
    var network = Network()
    
    
    @StateObject private var dataController = DataController()

    
    var body: some Scene {
        WindowGroup {
            
            SplashScreenView().environmentObject(network)
                .environment(\.managedObjectContext, dataController.container.viewContext)

        }
    }
}
