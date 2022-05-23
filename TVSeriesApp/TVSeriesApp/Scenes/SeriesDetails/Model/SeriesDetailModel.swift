//
//  SeriesDetailModel.swift
//  TVSeriesApp
//
//  Created by Michele de Olivio Corrêa on 22/05/22.
//

import Foundation

struct SeriesDetailModel {
    let mainInfo: SeriesDetailResponse
    let episodesBySeason: [Int: [EpisodesBySeasonResponse]]
}
