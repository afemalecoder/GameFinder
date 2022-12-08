//
//  FavoritesDetailView.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 05/12/2022.
//

import SwiftUI

struct FavouritesDetailView: View {
    var favorite: Favourites
    
    var body: some View {
        Text(favorite.name ?? "N/A")
        Text(favorite.summary ?? "N/A")
        
    }
}

struct FavoritesDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesDetailView(favorite: Favourites())
    }
}
