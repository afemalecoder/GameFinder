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
    for genre in games.genres ?? [TheGame.Genre]() {newFav.genres = genre.name }
    for mode in games.game_modes ?? [TheGame.Modes]() {newFav.gameModes = mode.name }
    for company in games.involved_companies ?? [TheGame.Companies]() {newFav.involvedCompanies = company.company.name }
//                        for mode in games.multiplayer_modes! {newFav.multiplayerModes = mode.name}
    for platform in games.platforms ?? [TheGame.Platform]() {newFav.platforms = platform.name }
    for perspective in games.player_perspectives ?? [TheGame.Perspective]() {newFav.playerPerspective = perspective.name }
    for screenshot in games.screenshots ?? [TheGame.Screenshots]() {newFav.screenshots = screenshot.image_id }
    newFav.slug = games.slug
    newFav.summary = games.summary
    for theme in games.themes ?? [TheGame.Themes]() {newFav.theme = theme.name }
//    for video in games.videos ?? [TheGame.Video]() {newFav.videos = video.video_id }
    
   
}
