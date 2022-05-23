//
//  EpisodesBySeasonResponse.swift
//  TVSeriesApp
//
//  Created by Michele de Olivio Corrêa on 22/05/22.
//

import Foundation

struct EpisodesBySeasonResponse: Codable {
    let id: Int
    let name: String
    let number: Int
    let season: Int
}
