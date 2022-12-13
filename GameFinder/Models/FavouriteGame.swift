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
    newFav.aggregatedRating = games.aggregated_rating ?? 0
    newFav.firstReleaseDate = Int64(games.first_release_date ?? 0)
    newFav.slug = games.slug
    newFav.summary = games.summary
}
