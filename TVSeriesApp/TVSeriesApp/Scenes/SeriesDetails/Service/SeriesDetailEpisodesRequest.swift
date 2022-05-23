//
//  SeriesDetailEpisodesRequest.swift
//  TVSeriesApp
//
//  Created by Michele de Olivio Corrêa on 22/05/22.
//

import Foundation

class SeriesDetailEpisodesRequest: RequestProtocol {
    var url: String = NetworkConstants.showEpisodes
    var method: HTTPMethod = .get
    var query: [String : Any] = [:]
    
    init(seasonId: Int) {
        url = String(format: url, seasonId)
    }
}
