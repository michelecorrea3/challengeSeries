//
//  EpisodesDetailsRequest.swift
//  TVSeriesApp
//
//  Created by Michele de Olivio Corrêa on 22/05/22.
//

import Foundation

class EpisodesDetailsRequest: RequestProtocol {
    var url: String = NetworkConstants.episodeInformation
    var method: HTTPMethod = .get
    var query: [String : Any]
    
    init(seriesId: Int, season: Int, number: Int) {
        url = String(format: url, seriesId)
        query = [
            "season": season,
            "number": number,
        ]
    }
}
