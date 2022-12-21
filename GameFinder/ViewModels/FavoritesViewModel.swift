//
//  FavoritesViewModel.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 02/12/2022.
//
//
//import Foundation
//import Firebase
//
//class FavoritesViewModel: ObservableObject {
//    
//    @Published var list = [FavoriteGame]()
//    
//    func getData() {
//        //Get a reference to the database
//        let db = Firestore.firestore()
//        
//        //Read the documents at specific path
//        db.collection("Games").getDocuments() { snapshot, error in
//            //Check for error
//            if error == nil {
//                print("no error")
//                if let snapshot = snapshot {
//                    print("snapshot")
//                    
//                    DispatchQueue.main.async {
//                        
//                        self.list = snapshot.documents.map { doc in
//                            print("got data")
//                            return FavoriteGame(id: doc.documentID, name: doc["name"] as? String ?? "N/A", notes: doc["Notes"] as? String ?? "N/A")
//                            
//                        }
//                    }
//                }
//            } else {
//                print("No data")
//            }
//        }
//    }
//}
