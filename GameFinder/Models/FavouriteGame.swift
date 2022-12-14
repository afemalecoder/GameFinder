//
//  FavoriteGame.swift
//  GameFinder
//
//  Created by Matilda Cederberg on 02/12/2022.
//

import SwiftUI

func FavouriteGame(games: TheGame, newFav: Favourites) {
    
    newFav.name = games.name
    newFav.cover = games.cover?.image_id
    newFav.id = Int64(games.id)
    newFav.slug = games.slug
}
