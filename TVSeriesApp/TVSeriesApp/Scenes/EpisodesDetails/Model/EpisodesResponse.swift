//
//  EpisodesResponse.swift
//  TVSeriesApp
//
//  Created by Michele de Olivio Corrêa on 22/05/22.
//

import Foundation

struct EpisodesResponse: Codable {
    let name: String
    let season: Int
    let number: Int
    let image: SeriesImage?
    let summary: String
}
