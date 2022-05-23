//
//  EpisodesDetailsViewData.swift
//  TVSeriesApp
//
//  Created by Michele de Olivio Corrêa on 22/05/22.
//

import Foundation

class EpisodesDetailsViewData {
    
    // MARK: - Properties

    let name: String
    let seasonEpisode: String
    let urlImage: String
    let summary: String
    
    // MARK: - Initializers

    init(name: String, number: Int, season: Int, urlImage: String, summary: String) {
        self.name = name
        self.seasonEpisode = String(format: "Season: %d - Episode: %d", season, number)
        self.urlImage = urlImage
        self.summary = summary
    }
}
