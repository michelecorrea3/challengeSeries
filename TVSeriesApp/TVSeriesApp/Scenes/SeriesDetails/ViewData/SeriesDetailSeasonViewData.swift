//
//  SeriesDetailSeasonViewData.swift
//  TVSeriesApp
//
//  Created by Michele de Olivio Corrêa on 22/05/22.
//

import Foundation

struct SeriesDetailSeasonViewData {
    var season: Int
    var episodesViewData: [SeriesDetailEpisodeViewData]
}

struct SeriesDetailEpisodeViewData {
    let name: String
}
