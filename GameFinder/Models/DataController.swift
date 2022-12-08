//
//  DataController.swift
//  CoreDataProject
//
//  Created by Matilda Cederberg on 29/11/2022.
//
import CoreData
import Foundation

class DataController: ObservableObject {
    
    let container = NSPersistentContainer(name: "FavoritesCoreData")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
}
