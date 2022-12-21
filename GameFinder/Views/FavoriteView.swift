//
//  FavortieView.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 01/12/2022.
//

import SwiftUI
import Firebase

struct FavoriteView: View {
    @ObservedObject var model = FavoritesViewModel()
    
    var body: some View {
          
        List{
            ForEach(model.list) { item in
                Text(item.name)
            }
                }
                .onAppear() {
                    model.getData()
            }
    }
   
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
